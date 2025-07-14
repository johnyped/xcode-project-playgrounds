//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import AVFoundation
import CoreML
import Vision
import SnapKit

class CustomViewController: UIViewController {
    
    private var lastProcessedTime: CFTimeInterval = 0
    private let frameProcessingInterval: CFTimeInterval = 1.0 / 10.0 // 10 FPS
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var videoOutput: AVCaptureVideoDataOutput!
    
    private var lastImage: UIImage?
    
    private var isCapturingVideo = false
    
    lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Video", for: .normal)
        button.addTarget(self,
                         action: #selector(toggleVideoCapture),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Result"
        label.textColor = .white
        label.backgroundColor = .black
        label.numberOfLines = 5
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCaptureSession()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTapToFocus(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapToFocus(_ gesture: UITapGestureRecognizer) {
        let tapPoint = gesture.location(in: view)
        focus(at: tapPoint)
    }
    
    func focus(at point: CGPoint) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        let focusPoint = videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: point)
        
        do {
            try device.lockForConfiguration()
            
            if device.isFocusPointOfInterestSupported {
                device.focusPointOfInterest = focusPoint
                device.focusMode = .autoFocus
            }
            
            if device.isExposurePointOfInterestSupported {
                device.exposurePointOfInterest = focusPoint
                device.exposureMode = .autoExpose
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error focusing on point: \(error)")
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(toggleButton)
        view.addSubview(resultLabel)
        
        toggleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toggleButton.snp.top)
        }
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }
        
        // Configure autofocus and auto exposure
        if videoCaptureDevice.isFocusModeSupported(.continuousAutoFocus) {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.focusMode = .continuousAutoFocus
            videoCaptureDevice.unlockForConfiguration()
        }
        
        if videoCaptureDevice.isExposureModeSupported(.continuousAutoExposure) {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.exposureMode = .continuousAutoExposure
            videoCaptureDevice.unlockForConfiguration()
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        //        videoPreviewLayer.snp.makeConstraints { make in
        //            make.edges.equalToSuperview()
        //        }
    }
    
    @objc private func toggleVideoCapture() {
        if isCapturingVideo {
            captureSession.stopRunning()
            toggleButton.setTitle("Start Video", for: .normal)
        } else {
            captureSession.startRunning()
            toggleButton.setTitle("Stop Video", for: .normal)
        }
        isCapturingVideo.toggle()
    }
}

extension CustomViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        let currentTime = CACurrentMediaTime()
        
        // Check if the required interval has passed since the last frame processing
        if currentTime - lastProcessedTime < frameProcessingInterval {
            return
        }
        
        lastProcessedTime = currentTime
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // image from buffer and rotate 90 degree on lastImage
        let img = self.imageFromCVImageBuffer(buffer: pixelBuffer)?.rotated(by: 90)
        
        //store image
        self.lastImage = img
        
        let famlilyMemberClassifier = try! FamlilyMemberClassifier_v1()
        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: famlilyMemberClassifier.model)) { (request, error) in
            guard
                let results = request.results as? [VNClassificationObservation]
            else { return }
            
            // debug
            print("###### Results Count: \(results.count)")
            results.forEach({
                print("\($0.identifier) \($0.confidence)")
            })
            
            let filterResults = results.filter({ $0.confidence > 0.3 })
            guard filterResults.count > 0 else { return }
            
            let description = self.describeResults(results: filterResults)
                        
            DispatchQueue.main.async {
                self.resultLabel.text = description
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }
}

extension CustomViewController {
    func describeResults(results: [VNClassificationObservation]) -> String? {
        guard
            !results.isEmpty
        else { return nil}
        
        let sorted = results.sorted {
            $0.confidence > $1.confidence
        }
        var text = "Result: \n"
        for result in sorted {
            text += "\(result.identifier) \(result.confidence * 100)%\n"
        }
        
        return text
    }
    
    func imageFromCVImageBuffer(buffer: CVImageBuffer) -> UIImage? {
        let ciImage = CIImage(cvImageBuffer: buffer)
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

extension UIImage {
    func rotated(by degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / 180
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: radians)).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContext(newSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        self.draw(in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
}

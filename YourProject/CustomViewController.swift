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
import CoreVideo

class CustomViewController: UIViewController {
    
    private var lastProcessedTime: CFTimeInterval = 0
    private let frameProcessingInterval: CFTimeInterval = 1.0 / 10.0 // 10 FPS
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var videoOutput: AVCaptureVideoDataOutput!
    var faceDetectionRequest: VNDetectFaceRectanglesRequest!
    var familyClassificationRequest: VNCoreMLRequest!
    
    private var lastImage: UIImage?
    
    private var isCapturingVideo = false
    
    lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Video", for: .normal)
        button.addTarget(self,
                         action: #selector(toggleVideoCapture),
                         for: .touchUpInside)
        button.backgroundColor = .black
        button.setTitleColor(.white,
                             for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCaptureSession()
        setupVision()
        
        let tapGesture = UITapGestureRecognizer(target: self, 
                                                action: #selector(handleTapToFocus(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        switch orientation {
            // Home button on top
        case UIDeviceOrientation.portraitUpsideDown:
            self.videoPreviewLayer.connection?.videoRotationAngle = 270
            // Home button on right
        case UIDeviceOrientation.landscapeLeft:
            self.videoPreviewLayer.connection?.videoRotationAngle = 0
            // Home button on left
        case UIDeviceOrientation.landscapeRight:
            self.videoPreviewLayer.connection?.videoRotationAngle = 180
            // Home button at bottom
        case UIDeviceOrientation.portrait:
            self.videoPreviewLayer.connection?.videoRotationAngle = 90
        default:
            self.videoPreviewLayer.connection?.videoRotationAngle = 90
        }
        self.videoPreviewLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(toggleButton)
        
        toggleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
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
        
    }
    
    func setupVision() {
        faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            if let results = request.results as? [VNFaceObservation] {
                self.handleFaceDetectionResults(results)
            }
        })
        
        let ml = try! FamlilyMemberClassifier_v1()
        let model = try! VNCoreMLModel(for: ml.model)
        
        familyClassificationRequest = VNCoreMLRequest(model: model,
                                                      completionHandler: { (request, error) in
            if let results = request.results as? [VNClassificationObservation] {
                self.handleFamilyClassificationResults(results)
            }
        })
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
    
    
    // use face and location detector and create bound frame around face
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
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                   orientation: .right,
                                                   options: [:])
        do {
            try requestHandler.perform([faceDetectionRequest])
        } catch {
            print(error)
        }
    }
    
    func handleFamilyClassificationResults(_ results: [VNClassificationObservation]) {
        DispatchQueue.main.async {
            print("### handleFamilyClassificationResults")
            print(results)
            
            if let topResult = results.first {
                //self.resultLabel.text = "\(topResult.identifier) (\(topResult.confidence * 100)%)"
                print("### topResult")
                print("\(topResult.identifier) (\(topResult.confidence * 100)%)")
            }
        }
    }    
    
    func createFaceRects(result: [VNFaceObservation]) -> [RectView] {
        let faceRects: [RectView] = result.map({
            let width = self.view.frame.width
            let height = self.view.frame.height
            let boundingBox = $0.boundingBox
            
            let size = CGSize(width: boundingBox.width * width,
                              height: boundingBox.height * height)
            let origin = CGPoint(x: boundingBox.minX * width,
                                 y: (1 - boundingBox.minY) * height - size.height)
            
            return RectView(frame: CGRect(origin: origin,
                                          size: size))
        })
        
        return faceRects
    }
    
    func runFamilyClassifyRequest(pixelBuffer: CVImageBuffer) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                            options: [:])
        try? handler.perform([familyClassificationRequest])
    }
        
    func handleFaceDetectionResults(_ results: [VNFaceObservation]) {
        DispatchQueue.main.async {
            
            // Remove all previous face views
            self.view.subviews.filter { $0 is RectView }.forEach { $0.removeFromSuperview() }

            // retrive late image
            guard let currentFrameImage = self.lastImage else { return }

            // set focus on face
            self.focusOnMostProminentFace(faces: results)
            
            // Create face rectangles and add them to the view
            let faceRects = self.createFaceRects(result: results)
            
            //faceRects.forEach { self.view.addSubview($0) }
            
            // Crop the image using the bounding boxes and classify each face
            for (index, faceObservation) in results.enumerated() {
                let boundingBox = faceObservation.boundingBox
                // scale boundingBox to fix human head
                let scale = 1.5
                let width = boundingBox.width * CGFloat(scale)
                let height = boundingBox.height * CGFloat(scale)
                let x = boundingBox.minX - (width - boundingBox.width) / 2
                let y = boundingBox.minY - (height - boundingBox.height) / 2
                let newBoundingBox = CGRect(x: x, y: y, width: width, height: height)
                
                if let croppedImage = self.cropImage(image: currentFrameImage,
                                                     boundingBox: newBoundingBox),
                   
                   let pixelBuffer = self.pixelBufferFromImage(image: croppedImage) {
                    self.runFamilyClassifyRequest(pixelBuffer: pixelBuffer) { [weak self]
                        classificationResult in
                        
                        guard let result = classificationResult else { return }
                        
                        DispatchQueue.main.async {
                            self?.view.addSubview(faceRects[index])
                            
                            faceRects[index].titleLabel.text = result.identifier
                            faceRects[index].confidentLabel.text = result.confidence.description
                            //self?.view.addSubview(faceRects[index])
                        }
                    }
                }
            }
        }
    }

    private func runFamilyClassifyRequest(pixelBuffer: CVPixelBuffer,
                                          completion: @escaping (VNClassificationObservation?) -> Void) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let ml = try! FamlilyMemberClassifier_v1()
        let model = try! VNCoreMLModel(for: ml.model)
        let request = VNCoreMLRequest(model: model) { (request, error) in
                 
            print("count : \(request.results?.count ?? 0)")
            
            guard
                let results = request.results as? [VNClassificationObservation],
                results.count > 0
            else {
                completion(nil)
                return
            }
            
            results.forEach({
                print("##################")
                print("### \($0.identifier)")
                print("### \($0.confidence.description)")
            })
            
            if let topResult = results.sorted(by: {
                $0.confidence > $1.confidence
            }).first {
                
                // topResult.identifier , topResult.confidence
                completion(topResult)
            } else {
                completion(nil)
            }
        }
        try? handler.perform([request])
    }

    private func focusOnMostProminentFace(faces: [VNFaceObservation]) {
        guard 
            let videoCaptureDevice = AVCaptureDevice.default(for: .video),
            faces.count > 0 else { return }
                
        // Find the face with the highest confidence
        let prominentFace = faces.max { a, b in a.confidence < b.confidence }
        guard let face = prominentFace else { return }
        
        // Convert face bounding box to camera coordinates
        let faceBoundingBox = face.boundingBox
        let cameraRect = videoPreviewLayer.layerRectConverted(fromMetadataOutputRect: faceBoundingBox)
        let focusPoint = CGPoint(x: cameraRect.midX / videoPreviewLayer.bounds.width,
                                 y: cameraRect.midY / videoPreviewLayer.bounds.height)
        
        if videoCaptureDevice.isFocusPointOfInterestSupported {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.focusPointOfInterest = focusPoint
            videoCaptureDevice.focusMode = .continuousAutoFocus
            videoCaptureDevice.unlockForConfiguration()
        }
    }
    
}

extension CustomViewController {
    
    func imageFromPixelBuffer(pixelBuffer: CVPixelBuffer) -> UIImage? {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func imageFromCVImageBuffer(buffer: CVImageBuffer) -> UIImage? {
        let ciImage = CIImage(cvImageBuffer: buffer)
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    private func captureCurrentFrameAsImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func cropImage(image: UIImage,
                   boundingBox: CGRect) -> UIImage? {
        let width = image.size.width * boundingBox.width
        let height = image.size.height * boundingBox.height
        let x = image.size.width * boundingBox.origin.x
        let y = image.size.height * (1 - boundingBox.origin.y - boundingBox.height)
        
        let cropRect = CGRect(x: x, y: y, width: width, height: height)
        
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    func pixelBufferFromImage(image: UIImage) -> CVPixelBuffer? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let attributes: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, attributes as CFDictionary, &pixelBuffer)
        
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, [])
        
        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        guard let ctx = context else {
            return nil
        }
        
        ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        CVPixelBufferUnlockBaseAddress(buffer, [])
        
        return buffer
    }
}


class RectView: UIView {
    
    lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.backgroundColor = .black
        element.text = ""
        element.textAlignment = .left
        return element
    }()
    
    lazy var confidentLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.backgroundColor = .black
        element.text = ""
        element.textAlignment = .left
        return element
    }()
    
    lazy var frameView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor.green.cgColor
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
        initConstriantLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initViews()
        initConstriantLayout()
    }
    
    private func initViews() {
        clipsToBounds = false
        
        self.addSubview(frameView)
        self.addSubview(titleLabel)
        self.addSubview(confidentLabel)
    }
    
    private func initConstriantLayout() {
        
        frameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints({ make in
            make.left.equalTo(frameView.snp.right)
            make.top.equalTo(frameView.snp.top)
            make.height.equalTo(23)
        })
        
        confidentLabel.snp.makeConstraints({ make in
            make.left.equalTo(frameView.snp.right)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(23)
        })
        
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

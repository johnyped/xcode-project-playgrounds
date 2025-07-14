//
//  PriceTarget.swift
//  YourProject
//
//  Created by IntrodexMac on 22/10/2567 BE.
//

import Foundation
import UIKit

struct PTChartVM {
    let startPoint: CGPoint
    let startNowShape: Circle
        
    let endMaxShape: Circle?
    let endAboveNowShape: [Circle]
    let endNowShape: Circle
    var endBelowNowShape: [Circle]
    let endAvgShape: HorizontalCapsule?
    let endMinShape: Circle?

    let maxLine: Line?
    let nowLine: SolidLine
    let avgLine: Line?
    let minLine: Line?

    // StartPoint to EndNowPoint to EndMaxPoint
    let upperTriagle: Triangle?
    
    // StartPoint to EndNowPoint to EndMinPoint
    let lowerTriagle: Triangle?
    
    
    init(startPoint: CGPoint,
         endX: CGFloat,
         yValues: [CGFloat],
         yAvg: CGFloat?) {
        self.startPoint = startPoint
        
        // Initialize shapes based on the provided yValues
        startNowShape = Circle.startCurrentPrice(center: startPoint)
        
        let endNowPoint = CGPoint(x: endX, y: startPoint.y)
        endNowShape = Circle.endCurrentPrice(center: endNowPoint)
        
        // Determine the end max point , use min to get max value
        let endMaxPoint = yValues.min().map { CGPoint(x: endX, y: $0) }
        //endMaxShape = endMaxPoint.map { Circle.endMaxPrice(center: $0) }
        if let endMaxPoint {
            let isLower = endMaxPoint.y > startPoint.y
            let isUpper = endMaxPoint.y < startPoint.y
            
            endMaxShape = isLower ? Circle.endBelowMaxPrice(center: endMaxPoint) :
                          isUpper ? Circle.endAboveMaxPrice(center: endMaxPoint) :
                          nil
            
            upperTriagle = isUpper ? Triangle.aboveCurrentPrice(startPoint: startPoint,
                                                                secondPoint: endNowPoint,
                                                                endPoint: endMaxPoint) :
                           nil
            
            maxLine = isLower ? DashLine.belowDashLine(from: startPoint, to: endMaxPoint) :
                      isUpper ? DashLine.aboveDashLine(from: startPoint, to: endMaxPoint) :
                      nil
        } else {
            endMaxShape = nil
            upperTriagle = nil
            maxLine = nil
        }
                
        // Determine the end min point , use max to get min value
        let endMinPoint = yValues.max().map { CGPoint(x: endX, y: $0) }
        
        if let endMinPoint {
            let isLower = endMinPoint.y > startPoint.y
            let isUpper = endMinPoint.y < startPoint.y
            
            endMinShape = isLower ? Circle.endBelowMinPrice(center: endMinPoint) :
                          isUpper ? Circle.endAboveCurrentPrice(center: endMinPoint) :
                          nil
            
            lowerTriagle = isLower ? Triangle.belowCurrentPrice(startPoint: startPoint,
                                                                secondPoint: endNowPoint,
                                                                endPoint: endMinPoint) :
                           nil
            
            minLine = isLower ? DashLine.belowDashLine(from: startPoint, to: endMinPoint) :
                      isUpper ? DashLine.aboveDashLine(from: startPoint, to: endMinPoint) :
                      nil
        } else {
            endMinShape = nil
            lowerTriagle = nil
            minLine = nil
        }
        
        // Create end above now shapes , use filter to get values above start point
        let endYAboveNow = yValues.filter { $0 < startPoint.y }
        endAboveNowShape = endYAboveNow.map { Circle.endAboveCurrentPrice(center: CGPoint(x: endX, y: $0)) }
        
        // Create end below now shapes , use filter to get values below start point
        let endYBelowNow = yValues.filter { $0 > startPoint.y }
        endBelowNowShape = endYBelowNow.map { Circle.endBelowCurrentPrice(center: CGPoint(x: endX, y: $0)) }
        
      
        // Line
        nowLine = SolidLine.currentPriceLine(from: startPoint,
                                             to: endNowPoint)
        
        // Determine the end average point
        let endAvgPoint = yAvg.map { CGPoint(x: endX, y: $0) }
        
        if let endAvgPoint {
            let isBelow = endAvgPoint.y > startPoint.y
            let isAbove = endAvgPoint.y < startPoint.y
            
            endAvgShape = isBelow ? HorizontalCapsule.endAvgPriceBelowNow(center: endAvgPoint) :
                          isAbove ? HorizontalCapsule.endAvgPriceAboveNow(center: endAvgPoint) :
                          nil
            
            avgLine = isBelow ? DashLine.belowDashLine(from: startPoint, to: endAvgPoint) :
                      isAbove ? DashLine.aboveDashLine(from: startPoint, to: endAvgPoint) :
                      nil
        } else {
            endAvgShape = nil
            avgLine = nil
        }
        
    }

}

// MARK: Shape protocol
protocol Shape {
    func draw(on view: UIView)
}

// MARK: Circle
struct Circle: Shape {
    let center: CGPoint
    let radius: CGFloat
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(center: CGPoint,
         radius: CGFloat,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 0.5,
         alpha: Float = 1.0)
    {
        self.center = center
        self.radius = radius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawCircle(at: center,
                        radius: radius,
                        color: fillColor,
                        strokeColor: strokeColor,
                        lineWidth: lineWidth,
                        alpha: alpha)
    }
    
    static func startCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 0.5,
                     alpha: 1)
    }
    
    static func endCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .gray,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endAboveMaxPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endBelowMaxPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .orange,
                     strokeColor: .black,
                     lineWidth: 1,
                        alpha: 1)
    }
    
    static func endAboveCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .green,
                     lineWidth: 0.5,
                     alpha: 0.5)
    }
    
    static func endBelowCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .orange,
                     strokeColor: .orange,
                     lineWidth: 0.5,
                     alpha: 0.5)
    }
    
    static func endAboveMinPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endBelowMinPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 3,
                     fillColor: .orange,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
}

// MARK: HorizontalCapsule
struct HorizontalCapsule: Shape {
    let center: CGPoint
    let width: CGFloat
    let height: CGFloat
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(center: CGPoint,
         width: CGFloat = 20,
         height: CGFloat = 10,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 1.0,
         alpha: Float = 1.0)
    {
        self.center = center
        self.width = width
        self.height = height
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawHorizontalCapsule(at: center,
                                   width: width,
                                   height: height,
                                   color: fillColor,
                                   strokeColor: strokeColor,
                                   lineWidth: lineWidth,
                                   alpha: alpha)
    }
    
    static func endAvgPriceAboveNow(center: CGPoint) -> Self {
        return .init(center: center,
                     width: 7,
                     height: 3,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endAvgPriceBelowNow(center: CGPoint) -> Self {
        return .init(center: center,
                     width: 7,
                     height: 3,
                     fillColor: .red,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
}

// MARK: Triangle
struct Triangle: Shape {
    let startPoint: CGPoint
    let secondPoint: CGPoint
    let endPoint: CGPoint
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(startPoint: CGPoint,
         secondPoint: CGPoint,
         endPoint: CGPoint,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 0.5,
         alpha: Float = 1.0)
    {
        self.startPoint = startPoint
        self.secondPoint = secondPoint
        self.endPoint = endPoint
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawTriangle(withPoints: startPoint,
                          pointB: secondPoint,
                          pointC: endPoint,
                          fillColor: fillColor,
                          strokeColor: strokeColor,
                          lineWidth: lineWidth,
                          alpha: alpha)
    }
    
    static func aboveCurrentPrice(startPoint: CGPoint,
                                  secondPoint: CGPoint,
                                  endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     secondPoint: secondPoint,
                     endPoint: endPoint,
                     fillColor: .green,
                     strokeColor: .green,
                     lineWidth: 1,
                     alpha: 0.5)
    }
    
    static func belowCurrentPrice(startPoint: CGPoint,
                                  secondPoint: CGPoint,
                                  endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     secondPoint: secondPoint,
                     endPoint: endPoint,
                     fillColor: .orange,
                     strokeColor: .orange,
                     lineWidth: 1,
                     alpha: 0.5)
    }
            
}

// MARK: Line protocol
protocol Line {
    func draw(on view: UIView)
}

// MARK: SolidLine
struct SolidLine: Line {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let strokeColor: UIColor = .black
    let lineWidth: CGFloat
    let alpha: Float
    
    func draw(on view: UIView) {
        view.drawStraightLine(from: startPoint,
                              to: endPoint,
                              strokeColor: strokeColor,
                              lineWidth: lineWidth,
                              alpha: alpha)
    }
    
    static func currentPriceLine(from startPoint: CGPoint,
                                 to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     lineWidth: 1.0,
                     alpha: 1.0)
    }
}

// MARK: DashLine
struct DashLine: Line {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let style: CAShapeLayerLineCap
    let lineWidth: CGFloat
    let lineColor: UIColor
    let alpha: Float
    let lineDashPattern: [NSNumber] = [4, 4]

    func draw(on view: UIView) {
        view.drawDashedLine(from: startPoint,
                            to: endPoint,
                            strokeColor: lineColor,
                            lineWidth: lineWidth,
                            lineDashPattern: lineDashPattern,
                            lineCap: style,
                            alpha: alpha)
    }
    
    static func aboveDashLine(from startPoint: CGPoint,
                              to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     style: .round,
                     lineWidth: 1,
                     lineColor: .green,
                     alpha: 1)
    }
    
    static func belowDashLine(from startPoint: CGPoint,
                              to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     style: .round,
                     lineWidth: 1,
                     lineColor: .orange,
                     alpha: 1)
    }
}

private
extension UIView {
    func drawStraightLine(from startPoint: CGPoint,
                          to endPoint: CGPoint,
                          strokeColor: UIColor = .black,
                          lineWidth: CGFloat = 2.0,
                          alpha: Float = 1.0) // Added alpha parameter
    {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(shapeLayer)
    }
    
    func drawDashedLine(from startPoint: CGPoint,
                        to endPoint: CGPoint,
                        strokeColor: UIColor = .black,
                        lineWidth: CGFloat = 2.0,
                        lineDashPattern: [NSNumber] = [2, 2],
                        lineCap: CAShapeLayerLineCap = .butt,
                        alpha: Float = 1.0) // Added alpha parameter
    {
        let dashedLinePath = UIBezierPath()
        dashedLinePath.move(to: startPoint)
        dashedLinePath.addLine(to: endPoint)
        
        let dashedShapeLayer = CAShapeLayer()
        dashedShapeLayer.path = dashedLinePath.cgPath
        dashedShapeLayer.strokeColor = strokeColor.cgColor
        dashedShapeLayer.lineWidth = lineWidth
        dashedShapeLayer.lineDashPattern = lineDashPattern // 6 points solid, 3 points space
        dashedShapeLayer.lineCap = lineCap
        dashedShapeLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(dashedShapeLayer)
    }
    
    func drawTriangle(withPoints pointA: CGPoint,
                      pointB: CGPoint,
                      pointC: CGPoint,
                      fillColor: UIColor = .blue,
                      strokeColor: UIColor = .black,
                      lineWidth: CGFloat = 2.0,
                      alpha: Float = 1.0) // Added alpha parameter
    {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: pointA)
        trianglePath.addLine(to: pointB)
        trianglePath.addLine(to: pointC)
        trianglePath.close() // Completes the triangle
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = fillColor.cgColor // Background color for the triangle
        triangleLayer.strokeColor = strokeColor.cgColor
        triangleLayer.lineWidth = lineWidth
        triangleLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(triangleLayer)
    }
    
    func drawCircle(at center: CGPoint,
                    radius: CGFloat = 2,
                    color: UIColor = .black,
                    strokeColor: UIColor = .black,
                    lineWidth: CGFloat = 2.0,
                    alpha: Float = 0.5) {
        // Create a circular path
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true)
        
        // Create a CAShapeLayer to hold the path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = color.cgColor // Set the circle fill color
        circleLayer.strokeColor = strokeColor.cgColor // Set the border color (optional)
        circleLayer.lineWidth = lineWidth // Set the border width
        circleLayer.opacity = alpha // Set opacity to 1.0 for full visibility
        
        // Add the circle layer to the view's layer
        self.layer.addSublayer(circleLayer)
    }
    
    func drawHorizontalCapsule(at centerPoint: CGPoint,
                               width: CGFloat,
                               height: CGFloat,
                               color: UIColor = .black,
                               strokeColor: UIColor = .black,
                               lineWidth: CGFloat = 2.0,
                               alpha: Float = 0.5) {
        // Calculate the origin based on the center point
        let originX = centerPoint.x - (width / 2)
        let originY = centerPoint.y - (height / 2)
        let capsulePath = UIBezierPath(roundedRect: CGRect(x: originX, y: originY, width: width, height: height), cornerRadius: height / 2)
        
        let capsuleLayer = CAShapeLayer()
        capsuleLayer.path = capsulePath.cgPath
        capsuleLayer.fillColor = color.cgColor
        capsuleLayer.strokeColor = strokeColor.cgColor
        capsuleLayer.lineWidth = lineWidth
        capsuleLayer.opacity = alpha
        
        self.layer.addSublayer(capsuleLayer)
    }
}


//
//  PriceTargetTests.swift
//  YourProject
//
//  Created by IntrodexMac on 22/10/2567 BE.
//

import XCTest
import UIKit

@testable import YourProject

final class PriceTargetTests: XCTestCase {
    
    func testInit_WithCurrentPriceIsMaxPrice() {
        
        // curentPrice == maxPrice
        let startPoint = CGPoint(x: 0,
                                 y: 10)
        let allEndPoints = Stub.simple10(x: 10)
        let priceTarget = PTChartVM(startPoint: startPoint,
                                      allEndPoints: allEndPoints)
        print(priceTarget)
        print("debug")
        
        XCTAssertEqual(priceTarget.startPoint, startPoint)
        XCTAssertEqual(priceTarget.allEndPoints, allEndPoints)
        
        // startNowShape
        XCTAssertEqual(priceTarget.startNowShape.center, startPoint)
        
        // endNowShape
        XCTAssertEqual(priceTarget.endNowShape.center,
                       CGPoint(x: 10,
                               y: 10))
        
        // endAboveNowShape
        XCTAssertEqual(priceTarget.endAboveNowShape.count, 0)
        
        // endbelowNowShape
        XCTAssertEqual(priceTarget.endBelowNowShape.count, 8)
        
        // endMaxShape
        XCTAssertEqual(priceTarget.endMaxShape?.center,
                       CGPoint(x: 10,
                               y: 10))
        
        
        
//         XCTAssertEqual(priceTarget.startPoint,
//                        CGPoint(x: 0,
//                                y: 10))
//         XCTAssertEqual(priceTarget.allEndPoints,
//                        simple10)
//
//         // test startNowShape
//         XCTAssertEqual(priceTarget.startNowShape.center,
//                        CGPoint(x: 0,
//                                y: 10))
//
//         // test endMaxShape
//         XCTAssertEqual(priceTarget.endMaxShape?.center,
//                        CGPoint(x: 10,
//                                y: 10))
//
//         // test endNowShape
//         XCTAssertEqual(priceTarget.endNowShape.center,
//                        CGPoint(x: 10,
//                                y: 10))
//
//         // test endAboveNowShape
//         XCTAssertEqual(priceTarget.endAboveNowShape,
//                        [CGPoint(x: 10,
//                                 y: 9)])
//
//         // test endBelowNowShape
//         XCTAssertEqual(priceTarget.endBelowNowShape,
//                        [CGPoint(x: 10,
//                                 y: 1)])
//
//         // test endAvgShape
//         XCTAssertEqual(priceTarget.endAvgShape?.center,
//                        CGPoint(x: 10,
//                                 y: 5.5))
//
//         // test maxLine
//         XCTAssertEqual(priceTarget.maxLine?.startPoint,
//                        CGPoint(x: 0,
//                                 y: 10))


    }
}

extension PriceTargetTests {
    struct Stub {
        static func simple10(x: CGFloat) -> [CGPoint] {
            (1 ... 10).map { index in
                return CGPoint(x: x,
                               y: CGFloat(index))
            }
        }
    }
}

/*

 struct PriceTarget {
     let startPoint: CGPoint
     let allEndPoints: [CGPoint]

     let startNowShape: Circle

     let endMaxShape: Circle?
     let endAboveNowShape: [Circle]
     let endNowShape: Circle
     let endBelowNowShape: [Circle]
     let endAvgShape: HorizontalCapsule?
     let endMinShape: Circle?

     let maxLine: Line?
     let nowLine: Line
     let avgLine: Line?
     let minLine: Line?

     // StartPoint to EndNowPoint to EndMaxPoint
     let upperTriagle: Triangle?
     
     // StartPoint to EndNowPoint to EndMinPoint
     let lowerTriagle: Triangle?

     init(startPoint: CGPoint,
          allEndPoints: [CGPoint])
     {
         self.startPoint = startPoint
         self.allEndPoints = allEndPoints

         // init shape
         startNowShape = Circle(center: startPoint,
                                radius: 2.5,
                                fillColor: .green,
                                strokeColor: .black,
                                lineWidth: 0.5,
                                alpha: 0.5)

         let endMaxPoint = allEndPoints.max(by: { $0.y < $1.y })
         
         if let endMaxPoint {
             endMaxShape = Circle(center: endMaxPoint,
                                  radius: 2.5,
                                  fillColor: .green,
                                  strokeColor: .green,
                                  lineWidth: 0.5,
                                  alpha: 0.5)
         }
         else {
             endMaxShape = nil
         }
         
         //let endNowPoint = allEndPoints.first(where: { $0.y == startPoint.y })
         let maxXEndPoint = allEndPoints.max(by: { $0.x < $1.x })?.x ?? 0
         let endNowPoint = CGPoint(x: maxXEndPoint,
                                   y: startPoint.y)
         
         endNowShape = Circle(center: endNowPoint,
                              radius: 2.5,
                              fillColor: .gray,
                              strokeColor: .black,
                              lineWidth: 0.5,
                              alpha: 1)
        
         
         // endAboveNowShape is point between endMaxShape and endNowShape but not include endMaxShape and endNowShape
         if let endMaxPoint
         {
             endAboveNowShape = allEndPoints.filter { point in
                 point.y > endNowPoint.y && point.y < endMaxPoint.y
             }.map {
                 Circle(center: $0,
                        radius: 2.5,
                        fillColor: .green,
                        strokeColor: .green,
                        lineWidth: 0.5,
                        alpha: 0.5)
             }
         } else {
             endAboveNowShape = []
         }

         let endMinPoint = allEndPoints.min(by: { $0.y < $1.y })
         if let endMinPoint {
             endMinShape = Circle(center: endMinPoint,
                                  radius: 3,
                                  fillColor: .black,
                                  strokeColor: .red,
                                  lineWidth: 0.5,
                                  alpha: 0.5)
         }
         else {
             endMinShape = nil
         }
         
         // endBelowNowShape is point between endNowShape and endMinShape but not include endNowShape and endMinShape
         if let endMinPoint = endMinPoint
         {
             endBelowNowShape = allEndPoints.filter { point in
                 point.y < endNowPoint.y && point.y > endMinPoint.y
             }.map {
                 Circle(center: $0,
                        radius: 2.5,
                        fillColor: .red,
                        strokeColor: .red,
                        lineWidth: 0.5,
                        alpha: 0.5)
             }
         } else {
             endBelowNowShape = []
         }

        
         // avg point y value
         let avgYEndPoint = allEndPoints.reduce(0, { $0 + $1.y }) / Double(allEndPoints.count)
         let avgXEndPoint = allEndPoints.max(by: { $0.x < $1.x })?.x ?? 0
         let avgPoint = CGPoint(x: avgXEndPoint,
                                y: avgYEndPoint)
         endAvgShape = HorizontalCapsule(center: avgPoint,
                                         width: 7,
                                         height: 4,
                                         fillColor: .red,
                                         strokeColor: .black,
                                         lineWidth: 1,
                                         alpha: 1)

         // Line
         if let endMaxPoint {
             maxLine = Line(startPoint: startPoint,
                            endPoint: endMaxPoint,
                            style: .round,
                            lineWidth: 1,
                            lineColor: .green,
                            alpha: 1)
         }
         else {
             maxLine = nil
         }
         
         nowLine = Line(startPoint: startPoint,
                        endPoint: endNowPoint,
                        style: .butt,
                        lineWidth: 1,
                        lineColor: .black,
                        alpha: 1)
         
         if let endMinPoint {
             minLine = Line(startPoint: startPoint,
                            endPoint: endMinPoint,
                            style: .round,
                            lineWidth: 1,
                            lineColor: .red,
                            alpha: 1)
         }
         else {
             minLine = nil
         }

     
         avgLine = Line(startPoint: startPoint,
                        endPoint: avgPoint,
                        style: .butt,
                        lineWidth: 1,
                        lineColor: .red,
                        alpha: 1)

         // Triangle
         
         if let endMaxPoint,
            let endMinPoint {
             upperTriagle = Triangle(startPoint: startPoint,
                                     secondPoint: endMaxPoint,
                                     endPoint: endNowPoint,
                                     width: 10,
                                     height: 10,
                                     fillColor: .green,
                                     strokeColor: .black,
                                     lineWidth: 1,
                                     alpha: 1)
         }
         else {
             upperTriagle = nil
         }
        
         if let endMinPoint {
             lowerTriagle = Triangle(startPoint: startPoint,
                                     secondPoint: endNowPoint,
                                     endPoint: endMinPoint,
                                     width: 10,
                                     height: 10,
                                     fillColor: .red,
                                     strokeColor: .black,
                                     lineWidth: 1,
                                     alpha: 1)
         }
         else {
             lowerTriagle = nil
         }
         
     }
 }

 protocol Shape {}

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
 }

 struct HorizontalCapsule: Shape {
     let center: CGPoint
     let width: CGFloat
     let height: CGFloat
     let fillColor: UIColor
     let strokeColor: UIColor
     let lineWidth: CGFloat
     let alpha: Float

     init(center: CGPoint,
          width: CGFloat,
          height: CGFloat,
          fillColor: UIColor = .black,
          strokeColor: UIColor = .black,
          lineWidth: CGFloat = 0.5,
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
 }

 struct Triangle: Shape {
     let startPoint: CGPoint
     let secondPoint: CGPoint
     let endPoint: CGPoint
     let width: CGFloat
     let height: CGFloat
     let fillColor: UIColor
     let strokeColor: UIColor
     let lineWidth: CGFloat
     let alpha: Float

     init(startPoint: CGPoint,
          secondPoint: CGPoint,
          endPoint: CGPoint,
          width: CGFloat,
          height: CGFloat,
          fillColor: UIColor = .black,
          strokeColor: UIColor = .black,
          lineWidth: CGFloat = 0.5,
          alpha: Float = 1.0)
     {
         self.startPoint = startPoint
         self.secondPoint = secondPoint
         self.endPoint = endPoint
         self.width = width
         self.height = height
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
 }

 struct Line: Shape {
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
 }


 */

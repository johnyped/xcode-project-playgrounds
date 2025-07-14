//
//  PTChartView.swift
//  YourProject
//
//  Created by IntrodexMac on 22/10/2567 BE.
//

import UIKit

public class PTChartView: UIView {
    
    func bind(_ vm: PTChartVM) {
        // draw triangle
        vm.upperTriagle?.draw(on: self)
        vm.lowerTriagle?.draw(on: self)
        
        // draw line
        vm.maxLine?.draw(on: self)
        vm.nowLine.draw(on: self)
        vm.avgLine?.draw(on: self)
        vm.minLine?.draw(on: self)
        
        //draw circle
        vm.endAboveNowShape.forEach {
            $0.draw(on: self)
        }
        
        vm.endBelowNowShape.forEach {
            $0.draw(on: self)
        }
        vm.endAvgShape?.draw(on: self)
        vm.endMinShape?.draw(on: self)
        vm.endMaxShape?.draw(on: self)
        
        vm.startNowShape.draw(on: self)
        vm.endNowShape.draw(on: self)
    }
    
}

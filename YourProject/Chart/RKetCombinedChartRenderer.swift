//
//  ChartRender.swift
//  YourProject
//
//  Created by IntrodexMac on 21/10/2567 BE.
//

import DGCharts
import Foundation
import UIKit

class RKetCombinedChartRenderer: CombinedChartRenderer {
    private(set) var maxPrice: Double?
    private(set) var minPirce: Double?

    convenience init(chart: CombinedChartView,
                     animator: Animator,
                     viewPortHandler: ViewPortHandler,
                     maxPrice: Double?,
                     minPrice: Double?) {
        self.init(chart: chart,
                  animator: animator,
                  viewPortHandler: viewPortHandler)
        self.minPirce = minPrice
        self.maxPrice = maxPrice
    }

    override func drawValues(context: CGContext) {
        guard let chart = chart else { return }

//        let lineChartRenderer = RKLineChartRenderer(dataProvider: chart,
//                                                    animator: animator,
//                                                    viewPortHandler: viewPortHandler,
//                                                    maxPrice: maxPrice,
//                                                    minPrice: minPirce)
//        lineChartRenderer.drawValues(context: context)
    }
}


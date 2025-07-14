//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import DGCharts
import Foundation
import SnapKit
import UIKit

class CustomViewController: UIViewController {
    // MARK: - Views
    lazy var chartContainerView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .fill
        element.distribution = .fill
        element.spacing = 0
        return element
    }()
    
    lazy var priceChartView: CombinedChartView = {
        let element = CombinedChartView()
        element.isUserInteractionEnabled = true
        element.accessibilityIdentifier = "assetInfo_chart_view"
        element.doubleTapToZoomEnabled = false
        element.highlightPerTapEnabled = true
        element.scaleXEnabled = false
        element.scaleYEnabled = false
        element.chartDescription.enabled = false
        element.dragYEnabled = false
        element.dragXEnabled = false
        element.pinchZoomEnabled = false
        element.noDataText = ""
        element.noDataTextColor = UIColor.clear

        element.leftAxis.enabled = false
        element.rightAxis.enabled = false
        element.xAxis.drawAxisLineEnabled = false
        element.xAxis.drawGridLinesEnabled = false
        element.leftAxis.drawAxisLineEnabled = false
        element.xAxis.drawLabelsEnabled = false

        element.drawGridBackgroundEnabled = false
        element.drawBordersEnabled = false

        element.legend.form = .none
        element.setScaleEnabled(false)

        element.maxVisibleCount = 5000
        element.rightAxis.axisMaximum = 100
        element.rightAxis.axisMinimum = 0

        element.setScaleMinima(1,
                               scaleY: 1)
        element.setViewPortOffsets(left: 0,
                                   top: 10,
                                   right: 0,
                                   bottom: 20)
        element.backgroundColor = .lightGray
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.black.cgColor

        return element
    }()

    lazy var priceTargetChartView: PTChartView = {
        let element = PTChartView()
        element.backgroundColor = .clear
        return element
    }()

    lazy var priceTargetCapsulesView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        return element
    }()
    
    // MARK: - Data Stores
    var priceTarget: PriceTargetResult?
    var priceChartDataSet: LineChartDataSet?
    var priceTargetChartDataSet: ScatterChartDataSet?
    var OHLCs: [OHLC] = []
    
    var capsuleSize: CGSize = .init(width: 0,
                                    height: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        initConstriantLayout()
        fetchChartData()
    }
    
    private func fetchChartData() {
        Task {
            let priceOHLCs = OHLC.Stub.simple1
            guard
                let currentPrice = priceOHLCs.last?.close,
                let priceTarget = MockPriceTargetGenerator().generateMockData(currentPrice: currentPrice).response.result
            else {
                print("No data")
                return
            }
            
            self.OHLCs = priceOHLCs
            self.priceTarget = priceTarget
            
            fetchDataSuccess(priceTarget: priceTarget,
                                   OHLCs: priceOHLCs)
        }
    }
    
    @MainActor
    func fetchDataSuccess(priceTarget: PriceTargetResult,
                          OHLCs: [OHLC]) {
        guard
            let currentPrice = OHLCs.last?.close
        else {
            print("No data")
            return
        }
        
        priceChartDataSet = createPriceChartDataSet(prices: OHLCs)
        priceTargetChartDataSet = createPriceTargetChartDataSet(priceTarget: priceTarget,
                                                                currentPrice: currentPrice)
        initChart()
    }
    
    private func createPriceChartDataSet(prices: [OHLC]) -> LineChartDataSet {
        let priceChartEntries = prices.enumerated().map { (index, item) in
            ChartDataEntry(x: Double(index),
                           y: item.close)
        }
        
        let dataSet = LineChartDataSet(entries: priceChartEntries,
                                       label: "Historical Price")
        dataSet.colors = [NSUIColor.blue]
        dataSet.valueColors = [NSUIColor.black]
        
        return dataSet
    }
    
    private func createPriceTargetChartDataSet(priceTarget: PriceTargetResult,
                                               currentPrice: Double) -> ScatterChartDataSet? {
        let summaryPriceTarget = priceTarget.priceTargetSummary
        
        guard
            let averagePriceTarget = Double(summaryPriceTarget.average)
        else {
            return nil
        }
        
        // scatter chart (target price)
        let priceTargetAmount = priceTarget.items
            .map({ $0.priceTarget })
            .map({ Double($0) ?? 0 })
        
        let priceTargetWithSummaryAmount = priceTargetAmount + [averagePriceTarget, currentPrice]
        let targetChartEntries = priceTargetWithSummaryAmount.map({ ChartDataEntry(x: 0, y: $0) })
        
        let dataSet = ScatterChartDataSet(entries: targetChartEntries,
                                          label: "")
        dataSet.colors = [NSUIColor.clear]
        dataSet.scatterShapeSize = 0
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        return dataSet
    }
    
    private func initViews() {
        view.backgroundColor = .white
        view.addSubview(chartContainerView)
        chartContainerView.addArrangedSubview(priceChartView)
        chartContainerView.addArrangedSubview(priceTargetChartView)
        chartContainerView.addArrangedSubview(priceTargetCapsulesView)
        chartContainerView.setCustomSpacing(6, after: priceTargetChartView)
    }

    private func initConstriantLayout() {
        chartContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        priceChartView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }

        priceTargetChartView.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceChartView)
            make.width.equalTo(30)
        }

        priceTargetCapsulesView.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceChartView)
            make.width.equalTo(capsuleSize.width)
        }
    }
    
    private func initChart() {
        renderPriceChart()
        renderPriceTargetChart()
        renderPriceTargetCapsules()
    }
    
    private func createChartRenderer() -> RKetCombinedChartRenderer? {
        guard
            let priceChartDataSet,
            let priceTargetChartDataSet
        else { return nil }
        
        let combine = priceChartDataSet.entries + priceTargetChartDataSet.entries
        let maxColsePriceOfChart = combine.map { $0.y }.max() ?? 0
        let minClosePriceOfChart = combine.map { $0.y }.min() ?? 0
        let renderer = RKetCombinedChartRenderer(chart: priceChartView,
                                                 animator: priceChartView.chartAnimator,
                                                 viewPortHandler: priceChartView.viewPortHandler,
                                                 maxPrice: maxColsePriceOfChart,
                                                 minPrice: minClosePriceOfChart)
        return renderer
    }
    
    private func renderPriceChart() {
        guard
            let priceChartDataSet,
            let priceTargetChartDataSet
        else { return }

        let lineChartData = LineChartData(dataSet: priceChartDataSet)
        let scatterChartData = ScatterChartData(dataSets: [priceTargetChartDataSet])

        let combinedChartData = CombinedChartData()
        combinedChartData.lineData = lineChartData
        combinedChartData.scatterData = scatterChartData

        priceChartView.data = combinedChartData
        priceChartView.renderer = createChartRenderer()
    }
    
    func renderPriceTargetChart() {
        guard
            let priceTargetChartDataSet,
            let priceTargetSummary = priceTarget?.priceTargetSummary,
            let avg = Double(priceTargetSummary.average),
            let now = OHLCs.last?.close
        else { return }
        
        guard
            let nowChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == now }),
            let avgChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == avg })
        else { return }
        
        let startPos: CGPoint = .init(x: 0,
                                      y: getChartPos(entry: nowChartDataEntry).y)
        let endX: CGFloat = priceTargetChartView.bounds.width
        let entries = priceTargetChartDataSet.entries
        
        let yValues: [CGFloat] = self.getPositions(entries: entries,
                                                   in: self.priceChartView).map({ CGFloat($0.y) })
        
        let vm = PTChartVM(startPoint: startPos,
                               endX: endX,
                               yValues: yValues,
                               yAvg: getChartPos(entry: avgChartDataEntry).y)
        
        priceTargetChartView.bind(vm)
    }
    
    func getPositions(entries: [ChartDataEntry],
                      in chartView: BarLineChartViewBase) -> [CGPoint]
    {
        entries.map {
            let p = chartView.getPosition(entry: $0,
                                          axis: .left)
            return p
        }
    }
    
    func getChartPos(entry: ChartDataEntry) -> CGPoint {
        let p = priceChartView.getPosition(entry: entry,
                                      axis: .left)
        return p
    }

}

// MARK: Stub Chart Data

extension CustomViewController {
    enum Stub {
        static func generateEntries(avg: Double,
                                    now: Double,
                                    other: [Double]) -> (minEntry: ChartDataEntry?,
                                                         maxEntry: ChartDataEntry?,
                                                         avgEntry: ChartDataEntry?,
                                                         nowEntry: ChartDataEntry?,
                                                         other: [ChartDataEntry]) {
            let x = Double(0)
            let avgEntry = ChartDataEntry(x: x,
                                          y: avg,
                                          data: avg)
            let nowEntry = ChartDataEntry(x: x,
                                          y: now,
                                          data: now)
            var otherEntries = other.sorted().enumerated().map { ref -> ChartDataEntry in
                ChartDataEntry(x: x,
                               y: ref.element,
                               data: Double(ref.element))
            }
            
            let minEntry = otherEntries.first
            let maxEntry = otherEntries.last
            
            otherEntries.removeLast()
            otherEntries.removeFirst()
            
            return (minEntry,
                    maxEntry,
                    avgEntry,
                    nowEntry,
                    otherEntries)
        }
        
    }
}

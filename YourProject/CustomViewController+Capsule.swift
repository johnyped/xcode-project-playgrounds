//
//  CustomViewController+Capsule.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//
import UIKit
import DGCharts

extension CustomViewController {
    
    struct CapsuleSource {
        enum Kind {
            case min
            case max
            case avg
            case now
            
            var title: String {
                switch self {
                case .min:
                    return "Min"
                case .max:
                    return "Max"
                case .avg:
                    return "Avg"
                case .now:
                    return "Now"
                }
            }
        }
        
        static let font: UIFont = .systemFont(ofSize: 12)
        
        let y: CGFloat
        let value: Double
        let textColor: UIColor
        let backgroundColor: UIColor
        let kind: Kind
        
        var valueWithFormatter: String {
            print(String(format: "%.2f", value))
            return String(format: "%.2f", value)
        }
                
        var valueLabelWidth: CGFloat {
            return TextHelper.sizeForSingleLine(fromText: String(valueWithFormatter),
                                                font: Self.font).width
        }
        
        func valueLabelWidth(font: UIFont) -> CGFloat {
            return TextHelper.sizeForSingleLine(fromText: String(valueWithFormatter),
                                                font: font).width
        }
        
        init(y: CGFloat,
             kind: CapsuleSource.Kind,
             value: Double,
             now: Double) {
            self.y = y
            self.kind = kind
            self.value = value
            
            if value < now {
                self.textColor = .red
                self.backgroundColor = .red.withAlphaComponent(0.3)
            } else if value > now {
                self.textColor = .green
                self.backgroundColor = .green.withAlphaComponent(0.3)
            } else {
                if kind == .now {
                    self.textColor = .black
                    self.backgroundColor = .black.withAlphaComponent(0.3)
                } else {
                    self.textColor = .green
                    self.backgroundColor = .green.withAlphaComponent(0.3)
                }
            }
        }
    }
    
    // MARK: renderCapsules
    func renderPriceTargetCapsules() {
        guard
            let priceTargetChartDataSet,
            let priceTargetSummary = priceTarget?.priceTargetSummary,
            let max = Double(priceTargetSummary.high),
            let min = Double(priceTargetSummary.low),
            let avg = Double(priceTargetSummary.average),
            let now = OHLCs.last?.close,
            let nowChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == now }),
            let maxChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == max }),
            let minChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == min }),
            let avgChartDataEntry = priceTargetChartDataSet.entries.first(where: { $0.y == avg })
        else { return }
        
        // find yPos
        let nowPos = getChartPos(entry: nowChartDataEntry)
        let avgPos = getChartPos(entry: avgChartDataEntry)
        let minPos = getChartPos(entry: minChartDataEntry)
        let maxPos = getChartPos(entry: maxChartDataEntry)
        
        let datasources: [CapsuleSource] = [.init(y: CGFloat(nowPos.y),
                                                  kind: .now,
                                                  value: now,
                                                  now: now),
                                            .init(y: CGFloat(avgPos.y),
                                                  kind: .avg,
                                                  value: avg,
                                                  now: now),
                                            .init(y: CGFloat(minPos.y),
                                                  kind: .min,
                                                  value: min,
                                                  now: now),
                                            .init(y: CGFloat(maxPos.y),
                                                  kind: .max,
                                                  value: max,
                                                  now: now)].sorted {
            $0.y < $1.y
        }
        
        capsuleSize.width = capsuleWidth(sources: datasources)
        
        let viewModels = createCapsules(by: datasources)
        
        viewModels.forEach { viewModel in
            let capsuleView = createCapsuleView(with: viewModel)
            priceTargetCapsulesView.addSubview(capsuleView)
        }
        
        // Update capsule container view layout
        self.priceTargetCapsulesView.snp.updateConstraints { make in
            make.width.equalTo(capsuleSize.width)
        }
    }
    
    func createCapsuleView(with viewModel: PTCapsuleVM) -> PTCapsuleView {
        let element = PTCapsuleView(frame: viewModel.frame)
        element.bind(viewModel)
        return element
    }
    
    func createCapsules(by capsules: [CapsuleSource],
                        from previousViewModel: PTCapsuleVM? = nil) -> [PTCapsuleVM] {
        guard let source = capsules.first else { return [] }
        
        let capsuleHeight = capsuleSize.height
        let minContainerHeight = calculateMinimumHeight(of: capsules)
        let inputHeight = calculateInputHeight(of: capsules)
        let startY: CGFloat = source.y - capsuleHeight / 2.0
        
        let viewModels: [PTCapsuleVM]
        
        if minContainerHeight > inputHeight {
            viewModels = createCompressedCapsules(from: capsules,
                                                  startY: startY)
        } else {
            viewModels = createNormalCapsules(from: capsules,
                                              previousViewModel: previousViewModel,
                                              startY: startY)
        }
        
        return viewModels
    }
    
    private func createCompressedCapsules(from capsules: [CapsuleSource],
                                          startY: CGFloat) -> [PTCapsuleVM] {
        let capsuleHeight = capsuleSize.height
        let minContainerHeight = calculateMinimumHeight(of: capsules)
        let maxY = startY + minContainerHeight
        let actualY = maxY > containerHeight ? startY - (maxY - containerHeight) : startY
        
        return capsules.enumerated().map { index, source in
            let originY = actualY + (CGFloat(index) * (capsuleHeight - overlapSpacing))
            let frame = CGRect(x: 0,
                               y: originY,
                               width: capsuleSize.width,
                               height: capsuleSize.height)
            return .init(title: source.kind.title,
                         value: source.valueWithFormatter,
                         frame: frame,
                         textColor: source.textColor,
                         backgroundColor: source.backgroundColor)
        }
    }
    
    func createNormalCapsules(from capsules: [CapsuleSource],
                              previousViewModel: PTCapsuleVM?,
                              startY: CGFloat) -> [PTCapsuleVM] {
        guard let source = capsules.first else { return [] }
        
        let originY: CGFloat = calculateOriginYForNormalCapsules(
            startY: startY,
            previousViewModel: previousViewModel
        )
        
        let frame = CGRect(x: 0,
                           y: originY,
                           width: capsuleSize.width,
                           height: capsuleSize.height)
        let viewModel = PTCapsuleVM(title: source.kind.title,
                                  value: source.valueWithFormatter,
                                  frame: frame,
                                  textColor: source.textColor,
                                  backgroundColor: source.backgroundColor)
        let remainingCapsules = Array(capsules.dropFirst())
        
        return [viewModel] + createCapsules(by: remainingCapsules,
                                            from: viewModel)
    }
        
    func capsuleWidth(sources: [CapsuleSource]) -> CGFloat {
        let maxSource = sources.max(by: { $0.valueLabelWidth < $1.valueLabelWidth })
        
        return (maxSource?.valueLabelWidth ?? 0) + (30 + 8 + 8 + 8)
    }
    
}

// MARK: - Calculator

private extension CustomViewController {
    
    var containerHeight: CGFloat { priceTargetCapsulesView.bounds.height }
    var overlapSpacing: CGFloat { 2.0 }
    
    func calculateMinimumHeight(of capsules: [CapsuleSource]) -> CGFloat {
        let amountOfCapsule = CGFloat(capsules.count)
        let capsuleHeight = capsuleSize.height
        
        guard capsules.count > 1 else { return capsuleHeight }
        
        return (capsuleHeight * amountOfCapsule) - (overlapSpacing * (amountOfCapsule - 1))
    }
    
    func calculateInputHeight(of capsules: [CapsuleSource]) -> CGFloat {
        let sorted = capsules.sorted(by: { $0.y < $1.y })
        let capsuleHeight = capsuleSize.height
        
        guard
            let minY = sorted.first?.y,
            let maxY = sorted.last?.y
        else { return capsuleHeight }
        
        return maxY - minY + capsuleHeight
    }
    
    private func calculateOriginYForNormalCapsules(startY: CGFloat,
                                                   previousViewModel: PTCapsuleVM?) -> CGFloat {
        let capsuleHeight = capsuleSize.height
        let maxY = startY + capsuleHeight
        var originY: CGFloat = startY
        
        if let previousMaxY = previousViewModel?.frame.maxY,
           startY - previousMaxY < -overlapSpacing {
            let overlapped = startY - previousMaxY
            originY -= overlapped + overlapSpacing
        } else if maxY > containerHeight {
            originY -= maxY - containerHeight
        } else if startY < 0 {
            originY = 0
        }
        
        return originY
    }
   
}

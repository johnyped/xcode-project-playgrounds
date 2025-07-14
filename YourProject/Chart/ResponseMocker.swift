//
//  ResponseMocker.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//

import Foundation
// MARK: - Data Models
struct PriceTargetResponse: Codable {
    let result: PriceTargetResult?
}

struct PriceTargetResult: Codable {
    let priceTargetSummary: PriceTargetSummary
    let items: [PriceTargetItem]
}

struct PriceTargetSummary: Codable {
    let high: String
    let average: String
    let low: String
}

struct PriceTargetItem: Codable {
    let analystFirm: String
    let priceTarget: String
    let date: String
}

// MARK: - Mock Data Generator
class MockPriceTargetGenerator {
    let mockAnalystFirms = [
        // Traditional Investment Banks
        "Goldman Sachs",
        "Morgan Stanley",
        "JP Morgan",
        "Citigroup Global Markets",
        "UBS Securities",
        "Deutsche Bank Securities",
        "Bank of America Securities",
        "Credit Suisse",
        "Barclays Capital",
        "HSBC Securities",
        
        // Boutique Investment Banks
        "Jefferies Group",
        "Piper Sandler",
        "Raymond James",
        "William Blair",
        "Cowen Group",
        
        // International Banks
        "Nomura Securities",
        "BNP Paribas",
        "Societe Generale",
        "Mizuho Securities",
        "RBC Capital Markets",
        
        // Research and Investment Firms
        "Bernstein Research",
        "Evercore ISI",
        "BMO Capital Markets",
        "Canaccord Genuity",
        "Wedbush Securities",
        
        // Modern Financial Institutions
        "SVB Securities",
        "KeyBanc Capital Markets",
        "Oppenheimer & Co",
        "Stifel Financial",
        "TD Securities"
    ]
    
    // MARK: - Price Target Generation Scenarios
    enum PriceTargetScenario: String {
        case bearish           // All targets below current price
        case bullish          // All targets above current price
        case mixedBearish     // Mixed targets, tendency lower
        case mixedBullish     // Mixed targets, tendency higher
        case highlyVolatile   // Wide range of targets
        case tightConsensus   // Narrow range of targets
        
        static func random() -> PriceTargetScenario {
            let scenarios: [PriceTargetScenario] = [
                .bearish, .bullish, .mixedBearish, .mixedBullish,
                .highlyVolatile, .tightConsensus
            ]
            return scenarios.randomElement()!
        }
    }
    
    func generatePriceTargetRange(currentPrice: Double,
                                  scenario: PriceTargetScenario = .random()) -> (min: Double, max: Double, scenario: PriceTargetScenario) {
        // Base volatility factors
        let lowVolatility = Double.random(in: 0.05...0.15)   // 5-15%
        let mediumVolatility = Double.random(in: 0.15...0.35) // 15-35%
        let highVolatility = Double.random(in: 0.35...0.70)   // 35-70%
        
        let range: (min: Double, max: Double) = {
            switch scenario {
            case .bearish:
                // All targets below current price
                let maxDown = currentPrice * (1 - lowVolatility)
                let minDown = currentPrice * (1 - mediumVolatility)
                return (minDown, maxDown)
                
            case .bullish:
                // All targets above current price
                let minUp = currentPrice * (1 + lowVolatility)
                let maxUp = currentPrice * (1 + mediumVolatility)
                return (minUp, maxUp)
                
            case .mixedBearish:
                // Mixed targets with bearish tendency
                let min = currentPrice * (1 - mediumVolatility)
                let max = currentPrice * (1 + lowVolatility)
                return (min, max)
                
            case .mixedBullish:
                // Mixed targets with bullish tendency
                let min = currentPrice * (1 - lowVolatility)
                let max = currentPrice * (1 + mediumVolatility)
                return (min, max)
                
            case .highlyVolatile:
                // Wide range of targets
                let min = currentPrice * (1 - highVolatility)
                let max = currentPrice * (1 + highVolatility)
                return (min, max)
                
            case .tightConsensus:
                // Narrow range of targets
                let volatility = lowVolatility / 2 // Even tighter range
                let bias = Double.random(in: -volatility...volatility) // Random slight bias
                let min = currentPrice * (1 + bias - volatility)
                let max = currentPrice * (1 + bias + volatility)
                return (min, max)
            }
        }()
        
        return (range.min, range.max, scenario)
    }
    
    func generateMockData(currentPrice: Double,
                          scenario: PriceTargetScenario = .random()) -> (response: PriceTargetResponse, scenario: PriceTargetScenario) {
        let numberOfItems = Int.random(in: 5...25)
        var items: [PriceTargetItem] = []
        
        // Generate price target range based on scenario
        let (minPriceTarget, maxPriceTarget, scenario) = generatePriceTargetRange(currentPrice: currentPrice,
                                                                                  scenario: scenario)
        
        // Generate random dates within last 30 days
        let calendar = Calendar.current
        let today = Date()
        
        // Create a set to track used firms
        var usedFirms = Set<String>()
        
        for _ in 0..<numberOfItems {
            let randomPrice = Double.random(in: minPriceTarget...maxPriceTarget)
            let randomDaysAgo = Int.random(in: 0...30)
            let randomDate = calendar.date(byAdding: .day, value: -randomDaysAgo, to: today)!
            
            // Ensure unique analyst firms
            var randomFirm: String
            repeat {
                randomFirm = mockAnalystFirms.randomElement()!
            } while usedFirms.contains(randomFirm)
            usedFirms.insert(randomFirm)
            
            let item = PriceTargetItem(
                analystFirm: randomFirm,
                priceTarget: String(format: "%.2f", randomPrice),
                date: formatDate(randomDate)
            )
            items.append(item)
        }
        
        // Sort items by price target descending
        items.sort { Double($0.priceTarget)! > Double($1.priceTarget)! }
        
        // Calculate summary based on items
        let priceTargets = items.compactMap { Double($0.priceTarget) }
        let summary = PriceTargetSummary(
            high: String(format: "%.2f", priceTargets.max() ?? 0),
            average: String(format: "%.2f", priceTargets.reduce(0, +) / Double(priceTargets.count)),
            low: String(format: "%.2f", priceTargets.min() ?? 0)
        )
        
        let result = PriceTargetResult(
            priceTargetSummary: summary,
            items: items
        )
        
        return (PriceTargetResponse(result: result), scenario)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withTimeZone]
        return formatter.string(from: date)
    }
}

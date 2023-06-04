//
//  ExerciseChartView.swift
//  Antimo
//
//  Created by Roli Bernanda on 05/06/23.
//

import SwiftUI
import Charts

struct ExerciseData: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let durationInMinute: Int32
    
    init(year: Int, month: Int, day: Int, durationInMinute: Int32) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.durationInMinute = durationInMinute
    }
}

struct ExerciseChartView: View {
    var lastTwoWeeksWeightData: [WeightData] {
        return getLastTwoWeeksWeightData()
    }
    
    var chartData = [
        (name: "Time (minute)", weightData: [
            WeightData(year: 2023, month: 6, day: 1, weight: 19.0),
            WeightData(year: 2023, month: 6, day: 2, weight: 17.0),
            WeightData(year: 2023, month: 6, day: 3, weight: 17.0),]),
        (name: "Average", weightData: [
            WeightData(year: 2023, month: 6, day: 1, weight: 16.7),
            WeightData(year: 2023, month: 6, day: 2, weight: 16.7),
            WeightData(year: 2023, month: 6, day: 3, weight: 16.7),]),
    ]
    
    
    func getLastTwoWeeksWeightData() -> [WeightData] {
        var out: [WeightData] = []
        
        let today = Date()
        let calendar = Calendar.current
        
        for i in 0..<14 {
            guard let date = calendar.date(byAdding: .day, value: -i, to: today) else {
                continue
            }
            
            let weight = Double.random(in: 50...100)
            
            let weightData = WeightData(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date), day: calendar.component(.day, from: date), weight: weight)

            out.append(weightData)
        }
        
        return out
    }

    var averageWeight: Double {
        let totalWeight = lastTwoWeeksWeightData.reduce(0) { $0 + $1.weight }
        let numberOfDataPoints = Double(lastTwoWeeksWeightData.count)
        return totalWeight / numberOfDataPoints
    }
    
    var body: some View {
        VStack {
            Chart {
                ForEach(chartData, id:\.name) { item in
                    ForEach(item.weightData) { v in
                        LineMark(
                            x: .value("Date", v.date),
                            y: .value("Weight", v.weight)
                        )
                    }
                    .foregroundStyle(by: .value("average", item.name))
                    .symbol(by: .value("average", item.name))
                    .interpolationMethod(.cardinal)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day(.twoDigits))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Color.anPrimaryLight.opacity(0.5))
            }
        }
    }
}

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
    var exerciseData: FetchedResults<Activity>

    var averageWeight: Int32 {
        let totalWeight = exerciseData.reduce(0) { $0 + ($1.exercise?.duration ?? 0) }
        let numberOfDataPoints = Int32(exerciseData.count)
        return totalWeight / numberOfDataPoints
    }
    
    var body: some View {
        VStack {
            Chart {
                ForEach(exerciseData, id:\.id) {
                    LineMark(
                        x: .value("Date", $0.createdAt ?? Date(), unit: .day),
                        y: .value("Time", $0.exercise?.duration ?? 0)
                    )
                    .interpolationMethod(.cardinal)
                    
                    PointMark(
                        x: .value("Date", $0.createdAt ?? Date(), unit: .day),
                        y: .value("Weight", $0.exercise?.duration ?? 0)
                    )
                }
            }
            .frame(height: 300)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day(.twoDigits), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
    }
}

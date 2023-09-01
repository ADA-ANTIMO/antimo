//
//  LineChartView.swift
//  Antimo
//
//  Created by Roli Bernanda on 05/06/23.
//

import SwiftUI
import Charts

import Charts
import SwiftUI

// MARK: - WeightData

struct WeightData: Identifiable {
  let id: UUID = .init()
  let date: Date
  let weight: Double

  init(year: Int, month: Int, day: Int, weight: Double) {
    date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
    self.weight = weight
  }
}

// MARK: - WeightChartView

struct WeightChartView: View {
  var petDatas: [Pet]

  var chartData = [
    (name: "Weight", weightData: [
      WeightData(year: 2023, month: 6, day: 1, weight: 19.0),
      WeightData(year: 2023, month: 6, day: 2, weight: 17.0),
      WeightData(year: 2023, month: 6, day: 3, weight: 17.0)]),
    (name: "Average", weightData: [
      WeightData(year: 2023, month: 6, day: 1, weight: 16.7),
      WeightData(year: 2023, month: 6, day: 2, weight: 16.7),
      WeightData(year: 2023, month: 6, day: 3, weight: 16.7)]),
  ]

  var lastTwoWeeksWeightData: [WeightData] {
    getLastTwoWeeksWeightData()
  }

  var averageWeight: Double {
    let totalWeight = lastTwoWeeksWeightData.reduce(0) { $0 + $1.weight }
    let numberOfDataPoints = Double(lastTwoWeeksWeightData.count)
    return totalWeight / numberOfDataPoints
  }

  var body: some View {
    VStack {
      Chart {
        ForEach(petDatas) {
          let date = $0.createdAt
          let weight = $0.weight

          LineMark(
            x: .value("Date", date, unit: .day),
            y: .value("Weight", weight))
            .interpolationMethod(.cardinal)

          PointMark(
            x: .value("Date", date, unit: .day),
            y: .value("Weight", weight))
        }
      }
      .frame(maxWidth: UIScreen.main.bounds.width)
      .chartXAxis {
        AxisMarks(values: .stride(by: .day)) { _ in
          AxisGridLine()
          AxisValueLabel(format: .dateTime.day(.twoDigits).month(.abbreviated), centered: true)
        }
      }
      .chartYAxis {
        AxisMarks(position: .leading)
      }
    }
  }

  func getLastTwoWeeksWeightData() -> [WeightData] {
    var out: [WeightData] = []

    let today = Date()
    let calendar = Calendar.current

    for currentDate in 0 ..< 14 {
      guard let date = calendar.date(byAdding: .day, value: -currentDate, to: today) else {
        continue
      }

      let weight = Double.random(in: 50 ... 100)

      let weightData = WeightData(
        year: calendar.component(.year, from: date),
        month: calendar.component(.month, from: date),
        day: calendar.component(.day, from: date),
        weight: weight)

      out.append(weightData)
    }

    return out
  }
}

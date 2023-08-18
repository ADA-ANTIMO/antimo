//
//  ANCalendar.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 08/06/23.
//

import CoreData
import SwiftUI

// MARK: - DateValue

struct DateValue: Identifiable {
  var id = UUID().uuidString
  var day: Int
  var date: Date
}

// Extending Date to get Current Month Dates...
extension Date {
  func getAllDates() -> [Date] {
    let calendar = Calendar.current

    // getting start date that will result time 00:00
    let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!

    let range = calendar.range(of: .day, in: .month, for: startDate)!

    // getting date...
    return range.compactMap { day -> Date in

      calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }
  }
}

// MARK: - ANCalendar

struct ANCalendar: View {
  // MARK: Internal

  @EnvironmentObject private var viewModel: JournalViewModel
  @Binding var currentDate: Date
  @Binding var currentMonth: Int

  var startDate: Date {
    Calendar.current.date(from: Calendar.current.dateComponents(
      [.year, .month],
      from: currentDate))!
  }

  var endDate: Date {
    let startDate = startDate
    let range = Calendar.current.range(of: .day, in: .month, for: startDate)!
    let endDate = Calendar.current.date(bySetting: .day, value: range.count, of: startDate)!

    return endDate
  }

  var body: some View {
    VStack(spacing: 20) {
      // Days...
      let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

      // Header and controller
      HStack(spacing: 4) {
        HStack {
          Text(extraData()[1])

          Text(extraData()[0])
        }

        Spacer()

        Button {
          withAnimation {
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
        }

        Button {
          withAnimation {
            currentMonth += currentMonth < 0 ? 1 : 0
          }
        } label: {
          Image(systemName: "chevron.right")
        }
        .grayscale(currentMonth == 0 ? 0.5 : 0)
        .disabled(currentMonth == 0)
      }

      // Day View...
      HStack(spacing: 0) {
        ForEach(days, id: \.self) {
          Text($0)
            .font(.inputLabel)
            .frame(maxWidth: .infinity)
        }
      }

      // Dates...
      // Lazy grid
      let columns = Array(repeating: GridItem(.flexible()), count: 7)

      LazyVGrid(columns: columns, spacing: 16) {
        ForEach(extractDate()) {
          dateItem(date: $0)
        }
      }
      .gesture(
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local).onEnded { value in
          let direction = Utilities.Swipe.direction(width: value.translation.width, height: value.translation.height)

          switch direction {
          case .left:
            withAnimation {
              currentMonth += currentMonth < 0 ? 1 : 0
            }
          case .right:
            withAnimation {
              currentMonth -= 1
            }
          default:
            print("no clue")
          }
        })

      HStack {
        Spacer()

        Text("Less Activity")

        Circle()
          .fill(Color.anLegendLight)
          .frame(width: 20, height: 20)

        Circle()
          .fill(Color.anLegendMedium)
          .frame(width: 20, height: 20)

        Circle()
          .fill(Color.anLegendHeavy)
          .frame(width: 20, height: 20)

        Text("More Activity")

        Spacer()
      }
      .font(.callout)

      Spacer()
    }
    .onChange(of: currentMonth) { _ in
      currentDate = getCurrentMonth()
    }
    .onAppear {
      viewModel.fetchActivityByDateRange(startDate: startDate, endDate: endDate)
    }
  }

  func getCurrentMonth() -> Date {
    let calendar = Calendar.current

    guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
      return Date()
    }

    return currentMonth
  }

  func extraData() -> [String] {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MMM"

    let date = formatter.string(from: currentDate)

    return date.components(separatedBy: " ")
  }

  func extractDate() -> [DateValue] {
    let calendar = Calendar.current

    let currentMonth = getCurrentMonth()

    var days = currentMonth.getAllDates().compactMap { date -> DateValue in
      // getting day...
      let day = calendar.component(.day, from: date)

      return DateValue(day: day, date: date)
    }

    // adding offset days to get exact week day...
    let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())

    for _ in 0 ..< firstWeekday - 1 {
      days.insert(DateValue(day: -1, date: Date()), at: 0)
    }

    return days
  }

  @ViewBuilder
  func dateItem(date: DateValue) -> some View {
    let key = Utilities.formattedDate(from: date.date, format: "EEEE, d MMM yyyy")
    let activityInDay = viewModel.activitiesByDate.activities[key]?.count ?? 0
    let hasNoActivity = activityInDay == 0
    let isNotDayOfMonth = date.day != -1

    VStack {
      if isNotDayOfMonth {
        Button {
          if !hasNoActivity {
            activityNavigation.push(to: .activitesPerDate(date.date))
          }
        } label: {
          if hasNoActivity {
            Text("\(date.day)")
              .frame(width: 25, height: 25)
              .padding(8)
              .background(
                Circle()
                  .stroke(Color.anLegendHeavy, lineWidth: 1)
                  .opacity(isNotDayOfMonth ? 1 : 0))
              .foregroundColor(Color.anLegendHeavy)
          } else {
            Text("\(date.day)")
              .frame(width: 25, height: 25)
              .padding(8)
              .background(
                Circle()
                  .fill(
                    activityInDay == 1
                      ? Color.anLegendLight
                      : activityInDay == 2 ? Color.anLegendMedium : Color.anLegendHeavy)
                    .opacity(isNotDayOfMonth ? 1 : 0))
          }
        }
        .disabled(hasNoActivity)
      }
    }
    .foregroundColor(Color.white)
  }

  // MARK: Private

  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
}

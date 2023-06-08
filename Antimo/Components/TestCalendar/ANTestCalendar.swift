import SwiftUI

// Extending Date to get Current Month Dates...
extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

struct TestCalendar:View {
    @State var currentDate: Date = Date.now
    
    // State for displaying month and change when button chevron clicked
    @State var currentMonth: Int = 0
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
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
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    
    func DateItem(date: DateValue) -> some View {
        VStack {
            if date.day != -1 {
                Text("\(date.day)")
                
            }
        }
        .foregroundColor(Color.white)
        .frame(width: 30, height: 30)
        .padding(8)
        .background(
            Circle()
                .fill(
                    Color.anLegendLight
                )
                .opacity(date.day != -1 ? 1 : 0)
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Days...
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            // Header and controller
            HStack(spacing: 4) {
                HStack() {
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
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
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
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) {
                   DateItem(date: $0)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 3.0, coordinateSpace: .local).onEnded{ value in
                    let direction = Utilities.Swipe.direction(width: value.translation.width, height: value.translation.height)
                    
                    switch(direction) {
                    case .left:
                        currentMonth -= 1
                    case .right:
                        currentMonth += 1
                    default:
                        print("no clue")
                    }
                }
            )
            
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
            // updating Month
            currentDate = getCurrentMonth()
        }
    }
}

struct TestCalendar_Previews: PreviewProvider {
    static var previews: some View {
        TestCalendar()
    }
}

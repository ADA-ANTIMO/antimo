//
//  ProfileView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import PhotosUI
import Charts

struct LineChartView: View {
    
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

struct WeightData: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let weight: Double
    
    init(year: Int, month: Int, day: Int, weight: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.weight = weight
    }
}

let lastTwoWeeksWeightData = [
    WeightData(year: 2023, month: 6, day: 1, weight: 19.0),
    WeightData(year: 2023, month: 6, day: 2, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 3, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 4, weight: 13.0),
    WeightData(year: 2023, month: 6, day: 5, weight: 19.0),
    WeightData(year: 2023, month: 6, day: 6, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 7, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 8, weight: 13.0),
    WeightData(year: 2023, month: 6, day: 9, weight: 19.0),
    WeightData(year: 2023, month: 6, day: 10, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 11, weight: 17.0),
    WeightData(year: 2023, month: 6, day: 12, weight: 13.0),
    WeightData(year: 2023, month: 6, day: 13, weight: 19.0),
    WeightData(year: 2023, month: 6, day: 14, weight: 17.0),
]

let chartData = [
    (name: "Weight", weightData: [
        WeightData(year: 2023, month: 6, day: 1, weight: 19.0),
        WeightData(year: 2023, month: 6, day: 2, weight: 17.0),
        WeightData(year: 2023, month: 6, day: 3, weight: 17.0),]),
    (name: "Average", weightData: [
        WeightData(year: 2023, month: 6, day: 1, weight: 16.7),
        WeightData(year: 2023, month: 6, day: 2, weight: 16.7),
        WeightData(year: 2023, month: 6, day: 3, weight: 16.7),]),
]

struct ProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 80, height: 80)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    
    var body: some View {
        CircularProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}


struct EventCard: View {
    var activity: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activity)
                .font(.cardActivity)
            
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "doc")
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .background { Rectangle().fill(.white).cornerRadius(8) }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Veterinary Name")
                        .font(.cardActivity)
                    Text("27 May 2023")
                        .font(.cardActivity)
                }
                
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            Color.anPrimaryLight
        )
        .cornerRadius(8)
    }
}

struct ProfileView: View {
    @StateObject var viewModel = ProfileModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ScrollView {
                VStack(spacing: 25) {
                    ZStack {
                        Rectangle()
                            .fill(Color.anPrimaryLight)
                            .cornerRadius(8)
                        
                        HStack(spacing: 20) {
                            EditableCircularProfileImage(viewModel: viewModel)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Tukang Kesroh")
                                Text("10 October 1999")
                                Text("Beagle")
                            }
                            
                            VStack(alignment: .trailing, spacing: 10) {
                                Text("Edit")
                                Text("24 y.o")
                                Text("26.65 Kg")
                            }
                            
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width)
                    
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Last Visit")
                        HStack (spacing: 10) {
                            EventCard(activity: "Veterinary")
                            EventCard(activity: "Grooming")
                        }
                        EventCard(activity: "Medication")
                    }
                    .padding(.horizontal)
                    
                    LineChartView()
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

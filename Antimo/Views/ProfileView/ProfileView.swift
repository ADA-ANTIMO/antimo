//
//  ProfileView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ANToolbar(title: "Summary") {
                Text("Share")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
            }
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
                            EventCard(activityType: "Veterinary", icon: "person", name: "Veterinary Name", date: Date())
                            EventCard(activityType: "Grooming", icon: "comb.fill", name: "Groomer Name", date: Date())
                        }
                        EventCard(activityType: "Medication", icon: "person", name:"Medicine", date: Date())
                    }
                    .padding(.horizontal)
                    
                    WeightChartView()
                        .padding(.horizontal)
                    
                    ExerciseChartView()
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

struct EventCard: View {
    var activityType: String
    var icon: String
    var name: String
    var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activityType)
                .font(.cardActivity)
            
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: icon)
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .background { Rectangle().fill(.white).cornerRadius(8) }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.cardActivity)
                    Text(Utilities.formattedDate(from: date))
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

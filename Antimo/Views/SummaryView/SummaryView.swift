//
//  ProfileView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import PhotosUI

struct SummaryView: View {
    @StateObject var viewModel = ProfileModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ANBaseContainer {
                ANToolbar(title: "Summary") {
                    Text("")
                }
            } children: {
                ScrollView {
                    VStack(spacing: 25) {
                        ZStack {
                            Rectangle()
                                .fill(Color.anPrimaryLight)
                                .cornerRadius(8)
                            
                            HStack(spacing: 20) {
                                EditableCircularProfileImage(viewModel: viewModel)
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(viewModel.renderedDogName)
                                        Spacer()
                                        HStack {
                                            Text("Edit").font(.toolbar).foregroundColor(.anNavigation)
                                            Image(systemName: "square.and.pencil").foregroundColor(.anNavigation)
                                        }
                                        .onTapGesture {
                                            viewModel.openProfileForm()
                                        }
                                    }
                                    HStack {
                                        Text(viewModel.renderedBOD)
                                        Spacer()
                                        Text(viewModel.renderedAge)
                                    }
                                    
                                    HStack {
                                        Text(viewModel.renderedBreed)
                                        Spacer()
                                        Text(viewModel.renderedWeight)
                                    }
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
        .snackbar(isPresented: $viewModel.showSnackBar, text: "Dog profile has been updated", type: .success)
        .sheet(isPresented: $viewModel.isEditting) {
            VStack {
                ANToolbar(leading: {
                    Text("Cancel")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture {
                            viewModel.closeProfileForm()
                        }
                }, title: "Edit Profile") {
                    Text("Update")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture {
                            viewModel.saveProfileData()
                        }
                }
                
                Group {
                    ANTextField(text: $viewModel.dogName, placeholder: "", label: "Dog Name")
                    ANTextField(text: $viewModel.gender, placeholder: "", label: "Gender")
                    ANDatePicker(date: $viewModel.bod, label: "Birth of date")
                    ANTextField(text: $viewModel.breed, placeholder: "", label: "Breed")
                    ANNumberField(text: $viewModel.weight, placeholder: "", label: "Weight")
                }
                .padding(.horizontal)
                
                VStack {
                    
                }
            }
            .padding(.vertical)
            
            Spacer()
            
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
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

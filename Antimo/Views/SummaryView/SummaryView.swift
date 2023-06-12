//
//  ProfileView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import PhotosUI
import CoreData

struct SummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)])
    private var petData: FetchedResults<Pet>
    
    @FetchRequest(sortDescriptors: [])
    private var exerciseData: FetchedResults<Activity>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "triggerDate", ascending: true)])
    private var events: FetchedResults<Event>
    
    @FetchRequest var activities: FetchedResults<Activity>
    
    @StateObject var viewModel = SummaryViewModel()
    @StateObject var eventVM = ActivityViewModel()
    @EnvironmentObject private var dashboardNavigation: DashboardNavigationManager
    
    init () {
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? Date.now
        let startDate = Calendar.current.startOfDay(for: lastWeek)
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now) ?? Date.now
        
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false)
        ]
        request.predicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt <= %@) AND (type == %@)", startDate as CVarArg, endDate as CVarArg, "Exercise")
        
        let activityRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        activityRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false)
        ]
        activityRequest.predicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt <= %@)", startDate as CVarArg, endDate as CVarArg)

        _activities = FetchRequest(fetchRequest: activityRequest)

        _exerciseData = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(title: "Summary") {
                Text("")
            }
        } children: {
            ScrollView {
                VStack(spacing: 25) {
                    // TODO: Activity recommendation system
                    
                    // MARK: Profile Card
                    ZStack {
                        Rectangle()
                            .fill(Color.anPrimaryLight)
                            .cornerRadius(8)
                        
                        HStack(spacing: 20) {
                            EditableCircularProfileImage(viewModel: viewModel, width: 80, height: 80)
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
                    
                    // MARK: Upcoming Event
                    VStack (alignment: .leading, spacing: 10) {
                        UpcomingEventView(vm: eventVM, events: events, onShowAll: {
                            dashboardNavigation.push(to: .allEvents) })
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: Latest Journal
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Latest Journal").font(.sectionHeading)
                            Spacer()
                        }
                        
                        if activities.isEmpty {
                            HStack {
                                Spacer()

                                Text("There are no journals\n available yet, let's make your\n journal soon")
                                    .font(.placeholder)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.gray)

                                Spacer()
                            }
                        } else {
                            VStack(spacing: 8) {
                                ForEach(activities.byDate.keys, id: \.self) { key in
                                    Section {
                                        ForEach(activities.byDate.activities[key] ?? [], id: \.self) { activity in
                                            let editAction = Action(id: UUID(), type: .Edit) {}
                                            
                                            let deleteAction = Action(id: UUID(), type: .Delete) {}
                                            
                                            ANActivityDetails(activity: activity, actions: [editAction, deleteAction])
                                        }
                                    } header: {
                                        HStack {
                                            Text(key)
                                                .font(.date)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: Weight Chart
                    if petData.isEmpty {
                        EmptyView()
                    } else {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Weight")
                            WeightChartView(petData: petData)
                            Text("Weight (Kg): \(viewModel.persistWeight)")
                        }
                        .padding()
                        .background(Color.anPrimary.opacity(0.1))
                    }
                    
                    
                    // MARK: Exercise Chart
                    if exerciseData.isEmpty {
                        EmptyView()
                    } else {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Exercise")
                            ExerciseChartView(exerciseData: exerciseData)
                            Text("Time (Minute)")
                        }
                        .padding()
                        .background(Color.anPrimary.opacity(0.1))
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
                        .foregroundColor(Color.anNavigation.opacity(viewModel.disabledSubmit ? 0.1 : 1))
                        .onTapGesture {
                            viewModel.saveProfileData(viewContext: viewContext)
                        }
                        .disabled(viewModel.disabledSubmit)
                }
                
                ScrollView {
                    EditableCircularProfileImage(viewModel: viewModel, width: 150, height: 180)
                    VStack(spacing: 22) {
                        ANTextField(text: $viewModel.dogName, placeholder: "", label: "Dog Name")
                        HStack(spacing: 20) {
                            Text("Dog Gender").font(.inputLabel)
                            
                            Picker("Dog Gender", selection: $viewModel.gender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }
                            .pickerStyle(.segmented)
                        }

                        ANDatePicker(date: $viewModel.bod, label: "Birth of date")
                        ANTextField(text: $viewModel.breed, placeholder: "", label: "Breed")
                        ANNumberField(text: $viewModel.weight, placeholder: "", label: "Weight", suffix: "Kg")
                    }
                    .padding(.horizontal)
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

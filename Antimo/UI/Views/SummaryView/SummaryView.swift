//
//  ProfileView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import CoreData
import PhotosUI
import SwiftUI

// MARK: - SummaryView

struct SummaryView: View {

  // MARK: Internal

  var startDate: Date {
    let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? Date.now

    return Calendar.current.startOfDay(for: lastWeek)
  }

  var endDate: Date {
    Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now) ?? Date.now
  }

  var body: some View {
    ANBaseContainer {
      ANToolbar(title: "Dashboard") {
        CircularProfileImage()
          .onTapGesture {
            summaryVM.openProfileForm()
          }
      }
    } children: {
      ScrollView {
        VStack(spacing: 25) {
          // TODO: Activity recommendation system

          // MARK: Upcoming Event

          VStack(alignment: .leading, spacing: 10) {
            UpcomingEventView()
          }
          .padding(.horizontal)

          // MARK: Latest Journal

          VStack(alignment: .leading, spacing: 10) {
            HStack {
              Text("Latest Journal").font(.sectionHeading)
              Spacer()
            }

            if activityVM.activities.isEmpty {
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
                ForEach(activityVM.activitiesByDate.keys, id: \.self) { key in
                  Section {
                    ForEach(activityVM.activitiesByDate.activities[key] ?? [], id: \.id) { activity in
                      let editAction = Action(type: .edit) { }

                      let deleteAction = Action(type: .delete) { }

                      ANActivityDetails(
                        activity: activity,
                        actions: [editAction, deleteAction],
                        showAction: false)
                    }
                  } header: {
                    HStack {
                      Text(key)
                        .font(.date)
                        .opacity(0.5)

                      Spacer()
                    }
                  }
                }
              }
            }
          }
          .padding(.horizontal)

          VStack(spacing: 0) {
            Button {
              summaryVM.openWeightSheet()
            } label: {
              HStack {
                Text("Weight")
                Spacer()
                Image(systemName: "chevron.right")
              }
              .padding()
              .foregroundColor(.black)
            }

            Divider().frame(height: 1)

            Button {
              summaryVM.isExerciseSheetPresented = true
            } label: {
              HStack {
                Text("Exercise")
                Spacer()
                Image(systemName: "chevron.right")
              }
              .padding()
              .foregroundColor(.black)
            }
          }
          .background(Color.anPrimary.opacity(0.1))
          .cornerRadius(8)
          .padding()
        }
      }
    }
    .snackbar(isPresented: $summaryVM.showSnackBar, text: "Dog profile has been updated", type: .success)
    .sheet(isPresented: $summaryVM.isEditting) {
      VStack {
        ANToolbar(leading: {
          Text("Cancel")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation)
            .onTapGesture {
              summaryVM.closeProfileForm()
            }
        }, title: "Edit Profile") {
          Text("Update")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation.opacity(summaryVM.disabledSubmit ? 0.1 : 1))
            .onTapGesture {
              summaryVM.saveProfileData()
            }
            .disabled(summaryVM.disabledSubmit)
        }

        ScrollView {
          EditableCircularProfileImage(width: 150, height: 180)
          VStack(spacing: 22) {
            ANTextField(text: $summaryVM.dogName, placeholder: "", label: "Dog Name")
            HStack(spacing: 20) {
              Text("Dog Gender").font(.inputLabel)

              Picker("Dog Gender", selection: $summaryVM.gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
              }
              .pickerStyle(.segmented)
            }

            ANDatePicker(date: $summaryVM.bod, label: "Birth of date")
            ANTextField(text: $summaryVM.breed, placeholder: "", label: "Breed")
            ANNumberField(text: $summaryVM.weight, placeholder: "", label: "Weight", suffix: "Kg")
          }
          .padding(.horizontal)
        }
      }
      .padding(.vertical)

      Spacer()
    }
    .sheet(isPresented: $summaryVM.isExerciseSheetPresented, onDismiss: { summaryVM.isExerciseSheetPresented = false }) {
      // MARK: Exercise Chart

      Group {
        if activityVM.exerciseActivities.isEmpty {
          Spacer()
          Text("There is no exercise data yet. Let's add some")
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
          Spacer()
        } else {
          VStack(alignment: .leading, spacing: 20) {
            Text("Exercise")
            ExerciseChartView(exerciseData: activityVM.exerciseActivities).frame(height: 250)
            Text("Time (Minute)")
          }
          .padding()
          .background(Color.anPrimary.opacity(0.1))
        }
      }
      .presentationDetents([.medium])
      .presentationDragIndicator(.visible)
    }
    .sheet(isPresented: $summaryVM.isWeightSheetPresented, onDismiss: { summaryVM.closeWeightSheet() }) {
      // MARK: Weight Chart

      Group {
        if !summaryVM.petDatas.isEmpty {
          VStack(alignment: .leading, spacing: 20) {
            Text("Weight")
            WeightChartView(petDatas: summaryVM.petDatas).frame(height: 200)
          }
          .padding()
          .background(Color.anPrimary.opacity(0.1))
        } else {
          Spacer()
          Text("There is no weight data yet. Let's add some")
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
          Spacer()
        }

        ANNumberField(text: $summaryVM.weight, placeholder: "", label: "Weight", suffix: "Kg").padding(.horizontal)
        ANButton("Save") {
          let petData = Pet(weight: Int(summaryVM.weight) ?? 0)

          summaryVM.createNewPetData(petData: petData)
          summaryVM.persistWeight = summaryVM.weight
          summaryVM.closeWeightSheet()
        }
        .padding(.horizontal)
      }
      .presentationDetents([.medium])
      .presentationDragIndicator(.visible)
    }
    .onAppear {
      activityVM.fetchActivityByDateRange(startDate: startDate, endDate: endDate)
      activityVM.fetchAllExerciseActivitiesByDateRange(startDate: startDate, endDate: endDate)
    }
  }

  // MARK: Private

  @EnvironmentObject private var activityVM: JournalViewModel
  @EnvironmentObject private var summaryVM: SummaryViewModel
  @EnvironmentObject private var dashboardNavigation: DashboardNavigationManager
}

// MARK: - SummaryView_Previews

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
  }
}

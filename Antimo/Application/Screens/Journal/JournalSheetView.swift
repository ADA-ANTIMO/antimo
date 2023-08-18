//
//  JournalSheetView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 06/06/23.
//

import SwiftUI

// MARK: - NutritionInputs

struct NutritionInputs: View {
  @EnvironmentObject var viewModel: JournalViewModel

  var body: some View {
    Group {
      ANTextField(text: $viewModel.menu, placeholder: "Food name", label: "Menu")

      Toggle(isOn: $viewModel.isEatenUp) {
        Text("Eaten Up?")
          .font(.inputLabel)
      }
    }
  }
}

// MARK: - ExerciseInputs

struct ExerciseInputs: View {
  @EnvironmentObject var viewModel: JournalViewModel

  var body: some View {
    Group {
      ANNumberField(text: $viewModel.duration, placeholder: "Duration in minutes", label: "Duration", suffix: "Minutes")

      ANMoodSelector(selectedMood: $viewModel.mood, label: "Mood")
    }
  }
}

// MARK: - GroomingInputs

struct GroomingInputs: View {
  @EnvironmentObject var viewModel: JournalViewModel

  var body: some View {
    Group {
      ANTextField(text: $viewModel.salon, placeholder: "Pet salon name", label: "Pet Salon")

      ANMoodSelector(selectedMood: $viewModel.mood, label: "Satisfaction")
    }
  }
}

// MARK: - JournalSheetView

struct JournalSheetView: View {

  // MARK: Internal

  var body: some View {
    ANBaseContainer {
      ANToolbar(leading: {
        Button(action: {
          viewModel.closeActivityForm()
        }, label: {
          Text("Cancel")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation)
        })
      }, title: viewModel.activityType.rawValue)
        .padding(.vertical)
    } children: {
      ScrollViewReader { proxy in
        ScrollView {
          VStack(spacing: 12) {
            if viewModel.activityType == .medication {
              ANActivityPicker(selected: $viewModel.title, label: "Activity:")
            } else {
              ANTextField(text: $viewModel.title, placeholder: "Activity name", label: "Activity Name")
            }

            ANDatePicker(date: $viewModel.date, label: "Date")

            ANTimePicker(time: $viewModel.time, label: "Time")

            switch viewModel.activityType {
            case .nutrition:
              NutritionInputs()
            case .medication:
              if viewModel.title == "Vet" {
                ANTextField(text: $viewModel.vet, placeholder: "Vet name", label: "Vet")
              }
            case .exercise:
              ExerciseInputs()
            case .grooming:
              GroomingInputs()
            default:
              EmptyView()
            }

            ANTextFieldArea(text: $viewModel.note, label: "Note (optional)", placeholder: "Activity note...")
              .id("note")
              .focused($keyboardVisible)

            ANImageUploader(
              imagePicker: viewModel.imagePicker,
              label: "\(viewModel.activityType.rawValue) photo (optional)")

            ANButton("Submit") {
              if viewModel.isUpdating {
                viewModel.submitEditForm()
              } else {
                viewModel.submitForm()
              }
            }
            .buttonStyle(.fill)
            .grayscale(viewModel.canSubmit ? 0 : 0.75)
            .opacity(viewModel.canSubmit ? 1 : 0.5)
            .disabled(!viewModel.canSubmit)
          }
          .padding(.horizontal, 16)
        }
        .onChange(of: keyboardVisible) { _ in
          if keyboardVisible {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              withAnimation(.easeInOut(duration: 1)) {
                proxy.scrollTo("note")
              }
            }
          }
        }
      }
    }
  }

  // MARK: Private

  @EnvironmentObject private var viewModel: JournalViewModel

  @FocusState private var keyboardVisible: Bool
}

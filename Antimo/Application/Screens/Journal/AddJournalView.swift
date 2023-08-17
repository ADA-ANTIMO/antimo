//
//  AddJournalView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

// MARK: - ActivityIcon

struct ActivityIcon: View {
  let icon: ActivityIcons

  var body: some View {
    ZStack {
      Image(icon.rawValue)
        .resizable()
        .frame(width: 37, height: 37)
    }
    .padding(8)
    .background(
      Color.white)
    .cornerRadius(8)
  }
}

// MARK: - ActivityOption

struct ActivityOption: View {
  let icon: ActivityIcons
  let label: String
  let action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      HStack(alignment: .center, spacing: 16) {
        ActivityIcon(icon: icon)

        Text(label)
          .font(.addActivity)
          .foregroundColor(Color.black)

        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: 48)
      .padding(.horizontal, 12)
      .padding(.vertical, 10)
      .background(
        Color.anPrimaryLight)
      .cornerRadius(8)
    }
  }
}

// MARK: - AddJournalView

struct AddJournalView: View {
  @EnvironmentObject private var journalNavigation: JournalNavigationManager
  @StateObject var viewModel = JournalViewModel()

  var body: some View {
    ANBaseContainer {
      ANToolbar(leading: {
        Button(action: {
          journalNavigation.goBack()
        }, label: {
          HStack {
            Image(systemName: "chevron.left")

            Text("Back")
          }
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
        })
      }, title: "Add Journal")
    } children: {
      VStack {
        ActivityOption(icon: .nutrition, label: "Nutrition") {
          viewModel.openActivityForm(selectedActivityType: .nutrition)
        }

        ActivityOption(icon: .medication, label: "Medication") {
          viewModel.openActivityForm(selectedActivityType: .medication)
        }

        ActivityOption(icon: .exercise, label: "Exercise") {
          viewModel.openActivityForm(selectedActivityType: .exercise)
        }

        ActivityOption(icon: .grooming, label: "Grooming") {
          viewModel.openActivityForm(selectedActivityType: .grooming)
        }

        ActivityOption(icon: .other, label: "Other") {
          viewModel.openActivityForm(selectedActivityType: .other)
        }
      }
      .padding()
    }
    .sheet(isPresented: $viewModel.isSheetPresented, onDismiss: {
      viewModel.resetState()
    }) {
      JournalSheetView()
        .environmentObject(viewModel)
    }
  }
}

// MARK: - AddJournalView_Previews

struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}

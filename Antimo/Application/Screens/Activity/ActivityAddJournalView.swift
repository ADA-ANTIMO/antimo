//
//  ActivityAddJournalView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

struct ActivityAddJournalView: View {
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @EnvironmentObject private var viewModel: JournalViewModel

  var body: some View {
    ANBaseContainer {
      ANToolbar(leading: {
        Button(action: {
          activityNavigation.goBack()
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
    .sheet(isPresented: $viewModel.isSheetPresented) {
      viewModel.resetState()
    } content: {
      JournalSheetView()
    }
  }
}

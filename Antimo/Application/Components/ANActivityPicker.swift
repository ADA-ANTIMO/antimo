//
//  ANActivityPicker.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
//

import SwiftUI

// MARK: - Medication

enum Medication: String, CaseIterable {
  case medicine = "Medicine"
  case vet = "Vet"
  case vaccine = "Vaccine"
  case vitamin = "Vitamin"
}

// MARK: - ANActivityPicker

struct ANActivityPicker: View {
  @Binding var selected: String
  @State var isDropdownShown = false

  let label: String

  var body: some View {
    HStack {
      Text(label)
        .font(.inputLabel)

      Spacer()

      Menu {
        ForEach(Medication.allCases, id: \.self) { activityType in
          Button {
            selected = activityType.rawValue
          } label: {
            Text(activityType.rawValue)
          }
        }
      } label: {
        HStack {
          Text(selected)

          Spacer()

          Image(systemName: "chevron.down")
            .foregroundColor(
              Color.anPrimary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .frame(maxWidth: 200)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.anPrimary))
        .onTapGesture {
          withAnimation {
            isDropdownShown.toggle()
          }
        }
      }
    }
    .onAppear {
      selected = Medication.medicine.rawValue
    }
  }
}

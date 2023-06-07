//
//  ANActivitySelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

enum AcitivityIcons: String {
    case nutrition = "carrot.fill"
    case medication = "cross.case.fill"
    case exercise = "tennisball.fill"
    case grooming = "comb.fill"
    case other = "heart.fill"
}

struct SelectorItem: View {
    let icon: AcitivityIcons;
    let label: String;
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon.rawValue)
                    .font(.system(size: 20))
                
                // hack for changing color svg
                //                .overlay(Rectangle().background(.red).blendMode(.overlay))
                
                Text(label)
                    .font(.activitySelector)
            }
            .frame(width: 60, height: 60)
            .background(
                Color.anPrimary.opacity(isSelected ? 1 : 0.5)
            )
            .foregroundColor(Color.white)
            .cornerRadius(8)
        }
        
    }
}

struct ANActivitySelector: View {
    @Binding var selected: ActivityTypes
    
    var body: some View {
        HStack(spacing: 16) {
            SelectorItem(icon: .nutrition, label: "Nutrition", isSelected: selected == .nutrition) {
                selected = .nutrition
            }
            SelectorItem(icon: .medication, label: "Medication", isSelected: selected == .medication) {
                selected = .medication
            }
            SelectorItem(icon: .exercise, label: "Exercise", isSelected: selected == .exercise) {
                selected = .exercise
            }
            SelectorItem(icon: .grooming, label: "Grooming", isSelected: selected == .grooming) {
                selected = .grooming
            }
            SelectorItem(icon: .other, label: "Other", isSelected: selected == .other) {
                selected = .other
            }
        }
    }
}

struct ANActivitySelector_Previews: PreviewProvider {
    static var previews: some View {
        ANActivitySelector(selected: .constant(.exercise))
    }
}

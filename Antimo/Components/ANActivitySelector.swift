//
//  ANActivitySelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

enum AcitivityIcons: String {
    case nutrition = "nutritionIcon"
    case medication = "medicationIcon"
    case exercise = "exerciseIcon"
    case grooming = "groomingIcon"
    case other = "otherIcon"
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
                VStack {
                    ZStack {
                        Image(icon.rawValue)
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                        Color.white.blendMode(.sourceAtop)
                    }
                    .frame(width: 28, height: 28)
                    .drawingGroup(opaque: false)
                }
                
                Text(label)
                    .font(.activitySelector)
            }
            .frame(width: 60, height: 60)
            .background(
                Color.anPrimary
            )
            .grayscale(isSelected ? 0 : 0.75)
            .opacity(isSelected ? 1 : 0.6)
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

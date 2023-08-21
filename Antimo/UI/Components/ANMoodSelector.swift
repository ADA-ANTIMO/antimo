//
//  ANMoodSelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//

import SwiftUI

enum Mood: String, CaseIterable{
    case veryLow = "veryLow"
    case low = "low"
    case medium = "medium"
    case high = "high"
    case veryHigh = "veryHigh"
}

struct MoodButton: View {
    let icon: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(icon)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(14)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.anPrimary, lineWidth: 1)
            )
            .cornerRadius(50)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ANMoodSelector: View {
    @Binding var selectedMood: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.inputLabel)
            
            HStack(alignment: .center) {
                ForEach(Mood.allCases, id: \.self) { mood in
                    MoodButton(icon: "mood\(mood.rawValue.capitalizedFirstLetter)")
                        .opacity(selectedMood == mood.rawValue ? 1 : 0.25)
                        .onTapGesture {
                            withAnimation {
                                selectedMood = mood.rawValue
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Color.anPrimaryLight
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        Color.anPrimary, lineWidth: 1
                    )
            )
            .cornerRadius(8)
        }
    }
}



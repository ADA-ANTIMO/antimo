//
//  ANMoodSelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//

import SwiftUI

struct MoodButton: View {
    let icon: String
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .font(.system(size: 20))
        }
        .padding(14)
        .background(Color(.white))
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color("PrimaryColor"), lineWidth: 1)
        )
        .cornerRadius(50)
    }
}

struct ANMoodSelector: View {
    var body: some View {
        HStack(alignment: .center) {
            MoodButton(icon:"face.smiling")
            
            Spacer()
            
            MoodButton(icon:"face.smiling")
            
            Spacer()
            
            MoodButton(icon:"face.smiling")
            
            Spacer()
            
            MoodButton(icon:"face.smiling")
            
            Spacer()
            
            MoodButton(icon:"face.smiling")
        }
        .frame(height: 64)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .background(
            Color("PrimaryColorLight")
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    Color("PrimaryColor"), lineWidth: 1
                )
        )
        .cornerRadius(8)
    }
}

struct ANMoodSelector_Previews: PreviewProvider {
    static var previews: some View {
        ANMoodSelector()
            .padding(.horizontal, 20)
    }
}

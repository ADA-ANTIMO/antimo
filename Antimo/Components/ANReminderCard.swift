//
//  ANReminderCard.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 01/06/23.
//

import SwiftUI

struct ReminderIcon: View {
    let icon: String
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .font(.system(size: 29))
        }
        .frame(width: 48, height: 48)
        .padding(8)
        .background(.white)
        .cornerRadius(8)
    }
}

struct ReminderDetails: View {
    let title: String
    let time: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.reminderTitle)
            
            Text(time)
                .font(.reminderTime)
        }
    }
}

struct ReminderToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
            }
            .frame(maxWidth: .infinity)
            .tint(Color("PrimaryColor"))
        }
        .scaledToFit()
    }
}

struct ANReminderCard: View {
    let icon: AcitivityIcons
    let title: String
    let time: String
    let frequency: String
    
    @State var isOn = false
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ReminderIcon(icon:icon.rawValue).foregroundColor(.anPrimary)
            
            ReminderDetails(title: title, time: time)
            
            Spacer()
            VStack {
                ReminderToggle(isOn: $isOn)
                Text(frequency)
                    .font(.reminderFrequency)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(Color.anPrimaryLight)
        .cornerRadius(8)
    }
}



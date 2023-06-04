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
        .padding(8)
        .background(
            Color.white
        )
        .cornerRadius(8)
    }
}

struct ReminderDetails: View {
    let title: String
    let time: String
    let frequency: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.reminderTitle)
            
            Spacer()
            
            Text(time)
                .font(.reminderTime)
        }
        
        Spacer()
        
        Spacer()
        
        VStack {
            Spacer()
            
            Text(frequency)
                .font(.reminderFrequency)
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
    let icon: String
    let title: String
    let time: String
    let frequency: String
    
    @State var isOn = false
    
    
    var body: some View {
        HStack(alignment: .center) {
            ReminderIcon(icon:icon)
            
            ReminderDetails(title: title, time: time, frequency: frequency)
            
            ReminderToggle(isOn: $isOn)
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            Color.anPrimaryLight
        )
        .cornerRadius(8)
    }
}



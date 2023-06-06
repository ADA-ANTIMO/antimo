//
//  ActivitySheetView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 06/06/23.
//

import SwiftUI

struct ActivitySheetView: View {
    var activityType:String
    var handleClose: () -> Void
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    handleClose()
                }, label: {
                    Text("Cancel")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                })
            }, title: activityType)
            .padding(.vertical)
        } children: {
            VStack {
                ANTextField(text: .constant(""), placeholder: "Activity name", label: "Activity Name")
                
                ANDatePicker(date: .constant(Date.now), label: "Date")
                
                ANTimePicker(time: .constant(Date.now), label: "Time")
                
                ANTextField(text: .constant(""), placeholder: "Food name", label: "Menu")
                
                Toggle(isOn: .constant(true)) {
                    Text("Food out?")
                        .font(.inputLabel)
                }
                
                ANTextFieldArea(text: .constant(""), label: "Note (optional)", placeholder: "Activity note...")
                
                ANTag(tagCount: 1)
                
                ANButton("Submit") {
                    handleClose()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ActivitySheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySheetView(activityType: "") {
            
        }
    }
}

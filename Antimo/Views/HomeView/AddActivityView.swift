//
//  AddActivityView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

struct ActivityIcon: View {
    let icon: String
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .font(.system(size: 29))
                .foregroundColor(Color.anPrimary)
        }
        .padding(8)
        .background(
            Color.white
        )
        .cornerRadius(8)
    }
}

struct ActivityOption: View {
    let icon: String
    let label: String
    
    var body: some View {
        Button {
            
        } label: {
            HStack(alignment: .center, spacing: 16) {
                ActivityIcon(icon:icon)
                
                Text(label)
                    .font(.addActivity)
                
                Spacer()
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
}

struct AddActivityView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        VStack() {
            ANToolbar(leading: {
                Button(action: {
                    routerManager.goBack()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        
                        Text("Back")
                    }
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                })
            }, title: "Add Activity")
            
            ActivityOption(icon:"carrot.fill", label: "Nutrition")
            ActivityOption(icon:"cross.case.fill", label: "Medication")
            ActivityOption(icon:"tennisball.fill", label: "Exercise")
            ActivityOption(icon:"comb.fill", label: "Grooming")
            ActivityOption(icon:"heart.fill", label: "Other")
            
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}

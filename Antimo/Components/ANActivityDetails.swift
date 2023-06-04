//
//  ANActivityDetails.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

enum ActivityActions: String, CaseIterable {
    case Delete = "Delete"
    case Edit = "Edit"
    
    func buttonRole() -> ButtonRole? {
        switch self {
            case .Delete:
                return ButtonRole.destructive
            case .Edit:
                return nil
        }
    }
}

struct ActivityMeta: View {
    let icon: String
    let time: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: icon)
                    .font(.system(size: 29))
            }
            .padding(8)
            .background(
                Color.white
            )
            .cornerRadius(8)
            
            Text(time)
                .font(.cardTime)
        }
        
    }
}

struct ActivityHeading: View {
    let activity: String
    let title: String
    
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack() {
                Text(activity)
                    .font(.cardActivity)
                
                Spacer()
                
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.blue)
                }
                .confirmationDialog("Select Action", isPresented: $showSheet) {
                    ForEach(ActivityActions.allCases, id:\.self) {
                        Button($0.rawValue, role: $0.buttonRole()) {
                            
                        }
                    }
                }
            }
            
            Text(title)
                .font(.cardTitle)
        }
    }
}

struct ActivitySalon: View {
    let salonName: String
    let satisfaction: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(salonName)
                .font(.cardExtra)
            
            Spacer()
            
            Image(systemName: satisfaction)
        }
    }
}

struct ANActivityDetails: View {
    let activity:DummyData
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ActivityMeta(icon: activity.icon, time: activity.time)
            
            // Details
            VStack(alignment: .leading, spacing: 16) {
                ActivityHeading(activity: activity.activity, title: activity.activity)
                
                ActivitySalon(salonName: activity.salonName, satisfaction: activity.satisfaction)
                
                // Desc
                Text(activity.desc)
                    .font(.cardContent)
                
                // Image
                Image(activity.image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            Color.anPrimaryLight
        )
        .cornerRadius(8)
    }
}

struct ANActivityDetails_Previews: PreviewProvider {
    static var previews: some View {
        ANActivityDetails(activity: DummyData())
            .padding(.horizontal, 10)
    }
}

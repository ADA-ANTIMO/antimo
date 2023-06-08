//
//  ANActivityDetails.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

enum ActivityActions: String, CaseIterable {
    case Edit = "Edit"
    case Delete = "Delete"
    
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
    let activity: String
    let time: String
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 29))
                       
                    Text(activity)
                        .font(.cardActivity)
                }
                .foregroundColor(Color.anPrimary)
            }
            .padding(8)
            .background(
                Color.white
            )
            .cornerRadius(8)
            
            Spacer()
            
            ZStack {
                Text(time)
                    .font(.cardTime)
            }
            .foregroundColor(Color.primary)
            .padding(8)
            .background(
                Color.white
            )
            .cornerRadius(8)
        }
    }
}

struct ActivityHeading: View {
    let title: String
    
    @State var showSheet: Bool = false
    
    var body: some View {
            HStack() {
                Text(title)
                    .font(.cardTitle)
                
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
    }
}

struct ActivityExtra: View {
    let icon: String
    let extra: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .foregroundColor(Color.anPrimary)
            
            Text(extra)
                .font(.cardExtra)
        }
    }
}

struct ActivityStatus: View {
    let status: String
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                Image(systemName: status)
                    .font(.system(size: 30))
            }
            .padding(8)
            .foregroundColor(Color.anPrimary)
            .background(
                Color.white
            )
            .cornerRadius(8)
        }
    }
}

struct ANActivityDetails: View {
    let activity:DummyData
    
    var body: some View {
        VStack() {
            ZStack(alignment: .top) {
                Image(activity.image)
                    .resizable()
                       .scaledToFill()
                       .frame(height: 200, alignment: .center)
                       .clipped()
                    
                VStack {
                    ActivityMeta(icon: activity.icon, activity: activity.activity, time: activity.time)
                    
                    Spacer()
                    
                   ActivityStatus(status: "face.smiling")
                }
                .padding(8)
            }
            .foregroundColor(.white)
            .frame(height: 200)
            
           
            
            // Details
            VStack(alignment: .leading, spacing: 16) {
                ActivityHeading(title: activity.activity)
                
                ActivityExtra(icon: "book", extra: "Dog Groomer Alaska")
                
                // Desc
                Text(activity.desc)
                    .font(.cardContent)
            }
            .padding(16)
        }
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

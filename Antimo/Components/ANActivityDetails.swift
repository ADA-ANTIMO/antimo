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

struct Action: Identifiable {
    let id: UUID
    let type: ActivityActions
    let action: () -> Void
}

struct ActivityMeta: View {
    let icon: String
    let type: String
    let createdAt: Date
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 29))
                       
                    Text(type)
                        .font(.cardActivity)
                        .foregroundColor(Color.anPrimary)
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
                let timeComponents = Utilities.getTime(date: createdAt)
                
                Text("\(timeComponents.hour!):\(timeComponents.minute!)")
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
    let actions:[Action]
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
                    ForEach(actions) { action in
                        Button(role: action.type.buttonRole()) {
                            action.action()
                        } label: {
                            Text(action.type.rawValue)
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
    let activity:ExerciseActivity
    let actions:[Action]
    
    var body: some View {
        VStack() {
            ZStack(alignment: .top) {
                let image = FileManager().retrieveImage(with: activity.activity!.imagePath) ?? UIImage(systemName: "exclamationmark.triangle.fill")!
                
                Image(uiImage: image)
                    .resizable()
                       .scaledToFill()
                       .frame(height: 200, alignment: .center)
                       .clipped()
                    
                VStack {
                    ActivityMeta(icon: "book", type: activity.activity!.type!, createdAt: activity.activity!.createdAt!)
                    
                    Spacer()
                    
                   ActivityStatus(status: "face.smiling")
                }
                .padding(8)
            }
            .foregroundColor(.white)
            .frame(height: 200)
            
           
            
            // Details
            VStack(alignment: .leading, spacing: 16) {
                ActivityHeading(actions: actions,title: activity.activity!.title!)
                
                ActivityExtra(icon: "book", extra: "Dog Groomer Alaska")
                
                // Desc
                Text(activity.activity!.note!)
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

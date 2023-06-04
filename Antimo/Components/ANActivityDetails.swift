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
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ActivityMeta(icon: "book", time: "14:00")
            
            // Details
            VStack(alignment: .leading, spacing: 16) {
                ActivityHeading(activity: "Grooming", title: "It's time to the grooming salon")
                
                ActivitySalon(salonName: "Dog Groomer Alaska", satisfaction: "face.smiling")
                
                // Desc
                Text("Grooming experience at Dog Groomer Alaska was exceptional. The groomer's expertise, professionalism, and friendly demeanor made us feel confident in their care for our beloved pet. Milo appeared happy and content after the grooming session, and we were satisfied with the results. It was a positive and gratifying experience, ensuring that Milo is well-groomed and looking their best.")
                    .font(.cardContent)
                
                // Image
                Image("dummyImg")
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
        ANActivityDetails()
            .padding(.horizontal, 10)
    }
}

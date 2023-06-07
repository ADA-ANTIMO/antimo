//
//  UpcomingEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct UpcomingEventView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Upcoming Events")
                
                Spacer()
                
                NavigationLink(value: Route.events) {
                    Text("Show All")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                }
                .navigationDestination(for: Route.self) {
                    $0
                }
            }
            
            ScrollView {
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
            }
        }
        .padding()
    }
}

struct UpcomingEventView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventView()
    }
}

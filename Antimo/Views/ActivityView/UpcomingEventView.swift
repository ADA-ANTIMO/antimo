//
//  UpcomingEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct UpcomingEventView: View {
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    var vm: ActivityViewModel
    var events: FetchedResults<Event>
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Upcoming Events").font(.sectionHeading)
                
                Spacer()
                
                Text("Show All")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture {
                        activityNavigation.push(to: .allEvents)
                    }
            }
            
            ForEach(events) { event in
                ANEventCard(
                    icon: vm.getIcon(event.reminder?.type ?? ""),
                    title: event.reminder?.title ?? "",
                    desc: event.reminder?.desc ?? "",
                    time: vm.getRenderedHourAndMinutes(event.triggerDate ?? Date())
                )
            }
        }
    }
}

//struct UpcomingEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingEventView(vm: ActivityViewModel(), events: [])
//    }
//}

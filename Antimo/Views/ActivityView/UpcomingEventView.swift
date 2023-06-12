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
    var onShowAll: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Upcoming Events").font(.sectionHeading)
                
                Spacer()
                
                if events.isEmpty {
                    EmptyView()
                } else {
                    Text("Show All")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture {
                            onShowAll()
                        }
                }
            }
            .padding(.top)
            
            if events.isEmpty {
                HStack {
                    Spacer()
                    Text("There are no upcoming events yet")
                        .font(.placeholder)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
            } else {
                ForEach(events.byDate.keys, id: \.self) { key in
                    Section {
                        ForEach(events.byDate.events[key] ?? [], id: \.self) { event in
                            ANEventCard(
                                icon: vm.getIcon(event.reminder?.type ?? ""),
                                title: event.reminder?.title ?? "",
                                desc: event.reminder?.desc ?? "",
                                time: vm.getRenderedHourAndMinutes(event.triggerDate ?? Date())
                            )
                        }
                    } header: {
                        HStack {
                            Text(key)
                                .font(.date).opacity(0.5)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

//struct UpcomingEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingEventView(vm: ActivityViewModel(), events: [])
//    }
//}

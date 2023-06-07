//
//  ActivityViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import SwiftUI

@MainActor
class ActivityViewModel: ObservableObject {
    @Published var selectedActivityType: ActivityTypes = .nutrition
    @Published var eventTitle: String = ""
    @Published var eventDesc: String = ""
    @Published var eventDate: Date = Date()
    @Published var eventTime: Date = Date()
    
    @Published var isEventSheetPresented: Bool = false
    @Published var isShowSnackBar: Bool = false
    
    func openEventSheet() {
        isEventSheetPresented = true
    }
    
    func closeEventSheet() {
        isEventSheetPresented = false
        resetEventSheetForm()
    }
    
    func resetEventSheetForm() {
        selectedActivityType = .nutrition
        eventTitle = ""
        eventDesc = ""
        eventDate = Date()
        eventTime = Date()
    }
    
    // TODO: Implement Save
    func saveEvent() {
        closeEventSheet()
        resetEventSheetForm()
        isShowSnackBar.toggle()
    }
    
}

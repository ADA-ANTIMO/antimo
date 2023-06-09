//
//  JournalViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import SwiftUI

@MainActor
class JournalViewModel: ObservableObject {
    @Published public var id: UUID = UUID()
    @Published public var image: String = ""
    @Published public var note: String = ""
    @Published public var title: String = ""
    @Published public var type: String = ""
    @Published public var vet: String = ""
    @Published public var mood: String = ""
    @Published public var duration: String = ""
    @Published public var isEatenUp: Bool = false
    @Published public var menu: String = ""
    @Published public var satisfaction: String = ""
    @Published public var salon: String = ""
    @Published public var createdAt: Date = Date()
    
    @Published public var date: Date = Date()
    @Published public var time: Date = Date()
    @Published public var isSheetPresented = false
    @Published public var selectedActivity: ActivityTypes = .nutrition
    
    public func resetState() {
        id = UUID()
        image = ""
        note = ""
        title = ""
        type = ""
        mood = ""
        duration = ""
        isEatenUp = false
        menu = ""
        satisfaction = ""
        salon = ""
        createdAt = Date()
        date = Date()
        time = Date()
    }
    
    public func openActivityForm(activity:ActivityTypes) {
        selectedActivity = activity
        isSheetPresented = true
    }
    
    public func closeActivityForm() {
        self.resetState()
        isSheetPresented = false
    }
    
    public func submitForm() {
        self.closeActivityForm()
    }
}

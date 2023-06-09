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
    @Published public var mood: String?
    @Published public var duration: Int?
    @Published public var isEatenUp: Bool?
    @Published public var menu: String?
    @Published public var satisfaction: Int16?
    @Published public var salon: String?
    @Published public var createdAt: Date = Date()
}

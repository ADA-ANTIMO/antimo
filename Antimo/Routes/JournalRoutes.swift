//
//  SwiftUIView.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import Foundation
import Combine
import SwiftUI

enum JournalRoute : String , Hashable {
    case addJournal
}

class JournalNavigationManager : ObservableObject{
    
    @Published var journalPaths = NavigationPath()
    
    func push(to route: JournalRoute) {
        journalPaths.append(route)
    }
    
    func goBack()  {
        journalPaths.removeLast()
    }
    
    func reset() {
        journalPaths = NavigationPath()
    }
}

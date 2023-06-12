//
//  RouteFinder.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import Foundation

enum DeepLinkURLs: String {
    case addJournals = "add_journals"
    case allEvents = "all_events"
}

struct RouteFinder {
    func find(from url: URL) async -> DeepLinkURLs? {
        guard let host = url.host() else { return nil }
        
        switch DeepLinkURLs(rawValue: host) {
        case .addJournals:
            return .addJournals
            
        case .allEvents:
            return .allEvents
            
        default:
            return nil
            
        }
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value?.replacingOccurrences(of: "+", with: " ")
        }
    }
}

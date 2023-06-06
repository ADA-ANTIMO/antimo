//
//  RouteFinder.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import Foundation

enum DeepLinkURLs: String {
    case addExercise = "add_exercise"
    case addNutrition = "add_nutrition"
}

struct RouteFinder {
    
//    func find(from url: URL) async -> Route? {
//        guard let host = url.host() else { return nil }
//        
//        switch DeepLinkURLs(rawValue: host) {
//        case .addExercise:
//            return .addExercise
//            
//        case .addNutrition:
//            return .addNutrition
//            
//        default:
//            return nil
//            
//        }
//    }
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

//
//  ANCard.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 04/06/23.
//

import SwiftUI

// Example component with custom style
struct ANCard<Content: View>: View {
    @Environment(\.cardStyle) var style
    var content: () -> Content
    
    var body: some View {
        style
            .makeBody(
                configuration: CardStyleConfiguration(
                    label: CardStyleConfiguration.Label(content: content())
                )
            )
    }
}

struct ANCard_Previews: PreviewProvider {
    static var previews: some View {
        ANCard {
            Text("Card")
        }
    }
}

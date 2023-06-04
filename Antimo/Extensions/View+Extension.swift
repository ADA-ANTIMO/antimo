//
//  View+Extension.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 04/06/23.
//

import SwiftUI

extension View {
  func cardStyle<S: CardStyle>(_ style: S) -> some View {
    environment(\.cardStyle, AnyCardStyle(style: style))
  }
}

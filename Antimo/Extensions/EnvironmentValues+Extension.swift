//
//  EnvironmentValues+Extension.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 04/06/23.
//

import SwiftUI

extension EnvironmentValues {
  var cardStyle: AnyCardStyle {
    get { self[CardStyleKey.self] }
    set { self[CardStyleKey.self] = newValue }
  }
}

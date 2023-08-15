//
//  ANButton.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - ANButton

struct ANButton: View {
  private let text: String
  private let role: ButtonRole?
  private let action: () -> Void

  init(_ text: String, role: ButtonRole? = nil, action: @escaping () -> Void) {
    self.text = text
    self.role = role
    self.action = action
  }

  var body: some View {
    Button(role: role) {
      action()
    } label: {
      Text(text)
    }
  }
}

// MARK: - ANButton_Previews

struct ANButton_Previews: PreviewProvider {
  static var previews: some View {
    ANButton("+") { }
      .buttonStyle(.circle)

    ANButton("Submit") { }
      .buttonStyle(.fill)

    ANButton("Submit") { }
      .buttonStyle(.outline)
  }
}

//
//  ANTextField.swift
//  Antimo
//
//  Created by Roli Bernanda on 31/05/23.
//

import Combine
import SwiftUI

// MARK: - ANTextField

struct ANTextField: View {
  @State var publisher = PassthroughSubject<String, Never>()
  @State var debouncedText = ""
  var debounceSeconds = 0.5

  @Binding var text: String
  var placeholder: String
  var label: String

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(label).font(.inputLabel)

      TextField(placeholder, text: $debouncedText)
        .font(.input)
        .padding(10)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.anPrimary, lineWidth: 1))
        .onChange(of: debouncedText) { value in
          publisher.send(value)
        }
        .onReceive(
          publisher.debounce(for: .seconds(debounceSeconds), scheduler: DispatchQueue.main))
      { value in
        text = value
      }
    }
    .onAppear {
      debouncedText = text
    }
  }
}

// MARK: - ANTextField_Previews

struct ANTextField_Previews: PreviewProvider {
  static var previews: some View {
    ANTextField(text: .constant("baba"), placeholder: "Your text here", label: "Test")
  }
}

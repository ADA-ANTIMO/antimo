//
//  StatefulPreviewWrapper.swift
//
//
//  Created by Bisma Mahendra I Dewa Gede on 08/04/23.
//

import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View {
  @State var value: Value
  var content: (Binding<Value>) -> Content

  var body: some View {
    VStack {
      content($value)
    }
  }

  init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
    _value = State(wrappedValue: value)
    self.content = content
  }
}

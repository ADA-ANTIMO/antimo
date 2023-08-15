//
//  ANSnackBar.swift
//  Antimo
//
//  Created by Roli Bernanda on 04/06/23.
//

import SwiftUI

// MARK: - SnackBarType

enum SnackBarType {
  case success
  case failed
}

// MARK: - SnackbarView

struct SnackbarView: View {
  let text: String
  let type: SnackBarType

  var body: some View {
    Text(text)
      .frame(width: UIScreen.main.bounds.width * 0.8)
      .padding()
      .foregroundColor(.white)
      .background(type == .success ? Color.green : Color.red)
      .cornerRadius(4)
      .transition(.move(edge: .top))
  }
}

// MARK: - SnackbarModifier

struct SnackbarModifier: ViewModifier {
  @Binding var isPresented: Bool
  let text: String
  let type: SnackBarType

  func body(content: Content) -> some View {
    ZStack(alignment: .top) {
      content
      if isPresented {
        VStack {
          SnackbarView(text: text, type: type)
            .onAppear(perform: {
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                  isPresented = false
                }
              }
            })
          Spacer()
        }
        .transition(.opacity)
      }
    }
  }
}

extension View {
  func snackbar(isPresented: Binding<Bool>, text: String, type: SnackBarType) -> some View {
    modifier(SnackbarModifier(isPresented: isPresented, text: text, type: type))
  }
}

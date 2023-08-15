//
//  ANToolbar.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 04/06/23.
//

import SwiftUI

// MARK: - ANToolbar

struct ANToolbar<Leading: View, Trailing: View>: View {

  // MARK: Lifecycle

  init(
    title: String) where Leading == AnyView, Trailing == AnyView
  {
    leading = nil
    self.title = title
    trailing = nil
  }

  init(title: String, @ViewBuilder trailing: @escaping () -> Trailing) where Leading == AnyView {
    leading = nil
    self.title = title
    self.trailing = trailing
  }

  init(@ViewBuilder leading: @escaping () -> Leading, title: String) where Trailing == AnyView {
    self.leading = leading
    self.title = title
    trailing = nil
  }

  init(@ViewBuilder leading: @escaping () -> Leading, title: String, @ViewBuilder trailing: @escaping () -> Trailing) {
    self.leading = leading
    self.title = title
    self.trailing = trailing
  }

  // MARK: Internal

  let leading: (() -> Leading)?
  let title: String
  let trailing: (() -> Trailing)?

  var body: some View {
    VStack {
      // Toolbar Item
      // TODO: find better way to style
      Grid {
        GridRow {
          // TODO: find way to have grid better
          HStack {
            if let leading {
              leading()
            } else {
              Text("")
            }

            Spacer()
          }

          HStack {
            Text(title)
              .font(.screenTitle)
          }

          HStack {
            Spacer()

            if let trailing {
              trailing()
            } else {
              Text("")
            }
          }
        }
        .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, 16)
      .padding(.top, 8)
      .padding(.bottom, 8)

      Divider()
    }
  }
}

// MARK: - ANToolbar_Previews

struct ANToolbar_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ANToolbar(leading: {
        Text("HIWHIWHIW")
      }, title: "Text")

      ANToolbar(title: "Text")

      ANToolbar(leading: {
        Text("HIWHIWHIW")
      }, title: "Text") {
        Button { } label: {
          Text("HEHEHE")
        }
      }
    }
  }
}

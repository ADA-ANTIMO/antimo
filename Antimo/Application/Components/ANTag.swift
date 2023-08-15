//
//  ANTag.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 03/06/23.
//

import SwiftUI

// MARK: - TagInput

struct TagInput: View {
  var body: some View {
    TextField("Tag", text: .constant(""))
      .font(.tag)
      .multilineTextAlignment(.center)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 8)
      .padding(.vertical, 12)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.anPrimary, lineWidth: 2))
      .cornerRadius(8)
  }
}

// MARK: - AddTagButton

struct AddTagButton: View {
  var body: some View {
    Button { } label: {
      Image(systemName: "plus")
    }
    .foregroundColor(Color.anPrimary)
    .padding(4)
    .background(
      Rectangle()
        .stroke(Color.anPrimary, lineWidth: 1))
  }
}

// MARK: - ANTag

// TODO: change how to layout tags
struct ANTag: View {

  // MARK: Lifecycle

  init(tagCount: Int = 8, maxTagPerRow: Int = 3) {
    let rowCount = Utilities
      .safeDivideIntRounded(
        num1: tagCount, num2: maxTagPerRow)

    rows = Array(0 ..< rowCount)
      .map { val in
        guard val + 1 != rowCount else {
          return tagCount - val * maxTagPerRow
        }

        return maxTagPerRow
      }
  }

  // MARK: Internal

  var rows: [Int]
  var tes = [3, 3, 2]

  var body: some View {
    Grid {
      ForEach(Array(zip(rows.indices, rows)), id: \.0) { index, colCount in
        GridRow {
          ForEach(0 ..< colCount, id: \.self) { _ in
            TagInput()
          }

          if index + 1 == rows.count {
            AddTagButton()
          }
        }
      }
    }
  }
}

// MARK: - ANTag_Previews

struct ANTag_Previews: PreviewProvider {
  static var previews: some View {
    ANTag()
  }
}

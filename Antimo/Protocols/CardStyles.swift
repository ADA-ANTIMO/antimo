//
//  CardStyles.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

//Example of creating custom style
struct CardStyleKey: EnvironmentKey {
  static var defaultValue = AnyCardStyle(style: DefaultCardStyle())
}

// TODO: create reusable custom style
protocol CardStyle {
    associatedtype Body: View
    typealias Configuration = CardStyleConfiguration
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
}

struct CardStyleConfiguration {
  /// A type-erased label of a Card.
  struct Label: View {
    init<Content: View>(content: Content) {
      body = AnyView(content)
    }

    var body: AnyView
  }

  let label: CardStyleConfiguration.Label
}


struct RoundedRectangleCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .padding()
      .background(RoundedRectangle(cornerRadius: 16).strokeBorder())
  }
}

struct CapsuleCardStyle: CardStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.white)
      .padding()
      .background(
        Capsule().fill(color)
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: -8))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: 4))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: 8))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: -4))
      )
  }
}

struct ShadowCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.black)
      .padding()
      .background(Color.white.cornerRadius(16))
      .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
  }
}

struct ColorfulCardStyle: CardStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.white)
      .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 2)
      .padding()
      .background(color.cornerRadius(16))
      .shadow(color: color, radius: 8, x: 0, y: 4)
  }
}

struct DefaultCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    #if os(iOS)
      return ShadowCardStyle().makeBody(configuration: configuration)
    #else
      return RoundedRectangleCardStyle().makeBody(configuration: configuration)
    #endif
  }
}

struct AnyCardStyle: CardStyle {
  private var _makeBody: (Configuration) -> AnyView

  init<S: CardStyle>(style: S) {
    _makeBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    _makeBody(configuration)
  }
}

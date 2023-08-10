//
//  ButtonStyles.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 13/06/23.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor(for: configuration.role))
            .frame(width: 35, height: 35)
            .padding(4)
            .background(color(for: configuration.role))
            .cornerRadius(100)
            .font(.system(size: 32))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
    
    func foregroundColor(for role:ButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? .white : .white
    }
    
    func color(for role:ButtonRole?) -> Color {
        switch role {
        case .cancel?, .destructive?:
            return .red
        default:
            return .anPrimary
        }
    }
}

extension ButtonStyle where Self == CircleButtonStyle {
    static var circle: CircleButtonStyle {
        CircleButtonStyle()
    }
}

struct OutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor(for: configuration.role))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color(for: configuration.role), lineWidth: 1)
            )
    }
    
    func foregroundColor(for role:ButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? .red : .anPrimary
    }
    
    func color(for role:ButtonRole?) -> Color {
        switch role {
        case .cancel?, .destructive?:
            return .red
        default:
            return .anPrimary
        }
    }
}

extension ButtonStyle where Self == OutlineButtonStyle {
    static var outline: OutlineButtonStyle {
        OutlineButtonStyle()
    }
}

struct FillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor(for: configuration.role))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(color(for: configuration.role))
            .cornerRadius(8)
    }
    
    func foregroundColor(for role:ButtonRole?) -> Color? {
        role == .destructive || role == .cancel ? .white : .white
    }
    
    func color(for role:ButtonRole?) -> Color {
        switch role {
        case .cancel?, .destructive?:
            return .red
        default:
            return .anPrimary
        }
    }
}

extension ButtonStyle where Self == FillButtonStyle {
    static var fill: FillButtonStyle {
        FillButtonStyle()
    }
}

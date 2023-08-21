//
//  ANButton.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

enum ButtonType {
    case Fill, Outline, Circle
}

struct FillButton: View {
    private let text: String
    private let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.anPrimary)
                .cornerRadius(8)
        }
    }
}

struct CircleButton: View {
    private let text: String
    private let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.white)
                .frame(width: 35, height: 35)
                .background(Color.anPrimary)
                .cornerRadius(100)
        }
    }
}

struct OutlineButton: View {
    private let text: String
    private let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.anPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.anPrimary, lineWidth: 1)
                )
        }
    }
}

struct ANButton: View {
    private let text: String
    private let buttonType: ButtonType
    private let action: () -> Void
    
    init(_ text: String, buttonType:ButtonType = .Fill, action: @escaping () -> Void) {
        self.text = text
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        switch buttonType {
            case .Fill:
                FillButton(text) {
                    action()
                }
                .font(.button)
            case .Outline:
                OutlineButton(text) {
                    action()
                }
                .font(.button)
        case .Circle:
            CircleButton(text) {
                action()
            }
        }
    }
}



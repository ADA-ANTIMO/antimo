//
//  ANButton.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

enum ButtonType {
    case Fill, Outline
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
        }
        .foregroundColor(Color(.white))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color("PrimaryColor"))
        .cornerRadius(8)
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
        }
        .foregroundColor(Color("PrimaryColor"))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("PrimaryColor"), lineWidth: 1)
        )
        
       
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
        case .Outline:
            OutlineButton(text) {
                action()
            }
        }
    }
}

struct ANButton_Previews: PreviewProvider {
    static var previews: some View {
        ANButton("Buttonku", buttonType: .Outline) {
            print("Hehehehe")
        }
        .padding(.horizontal, 20)
    }
}

//
//  ANTextField.swift
//  Antimo
//
//  Created by Roli Bernanda on 31/05/23.
//

import SwiftUI

struct ANTextField: View {
    @Binding var text: String
    
    var placeholder: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.inputLabel)
            
            TextField(placeholder, text: $text)
                .font(.input)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.anPrimary, lineWidth: 1)
                )
        }
    }
}

struct ANTextField_Previews: PreviewProvider {
    static var previews: some View {
        ANTextField(text: .constant("baba"), placeholder: "Your text here", label: "Test")
    }
}

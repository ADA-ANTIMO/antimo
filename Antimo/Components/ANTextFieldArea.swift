//
//  ANTextFieldArea.swift
//  Antimo
//
//  Created by Roli Bernanda on 31/05/23.
//

import SwiftUI

struct ANTextFieldArea: View {
    @Binding var text: String
    var label: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.inputLabel)
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.input)
                        .foregroundColor(Color.gray)
                        .padding(10)
                        .zIndex(1)
                }
                
                TextEditor(text: $text)
                    .font(.input)
                    .padding(4)
                    .border(Color.anPrimary, width: 1)
            }
        }
    }
}

struct ANTextFieldArea_Previews: PreviewProvider {
    static var previews: some View {
        ANTextFieldArea(text: .constant("note"), label: "Note", placeholder: "Enter your note...")
    }
}

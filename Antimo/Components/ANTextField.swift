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
            Text(label).font(.headline)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.gray)
                        .padding(10)
                }
                
                TextField("", text: $text)
                    .padding(10)
                    .border(Color.primary, width: 1)
            }
        }
    }
}

struct ANTextField_Previews: PreviewProvider {
    static var previews: some View {
        ANTextField(text: .constant("exercise"), placeholder: "Your text here", label: "Test")
    }
}

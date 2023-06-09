//
//  ANNumberField.swift
//  Antimo
//
//  Created by Roli Bernanda on 06/06/23.
//

import SwiftUI
import Combine

struct ANNumberField: View {
    @Binding var text: String
    
    var placeholder: String
    var label: String
    var suffix: String
    

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.inputLabel)
            
            HStack {
                TextField(placeholder, text: $text)
                    .font(.input)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(text)) { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        if filtered != newValue {
                            self.text = filtered
                        }
                    }
                
                Text(suffix)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.anPrimary, lineWidth: 1)
            )
        }
    }
}

struct ANNumberField_Previews: PreviewProvider {
    static var previews: some View {
        ANNumberField(text: .constant("baba"), placeholder: "Your text here", label: "Test", suffix: "kg")
    }
}

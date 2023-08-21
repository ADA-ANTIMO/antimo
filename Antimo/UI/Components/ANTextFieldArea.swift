//
//  ANTextFieldArea.swift
//  Antimo
//
//  Created by Roli Bernanda on 31/05/23.
//

import SwiftUI
import Combine

struct ANTextFieldArea: View {
    @State var publisher = PassthroughSubject<String, Never>()
    @State var debouncedText = ""
    var debounceSeconds = 0.5
    
    @Binding var text: String
    var label: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.inputLabel)
            
            ZStack(alignment: .topLeading) {
                if debouncedText.isEmpty {
                    Text(placeholder)
                        .font(.input)
                        .foregroundColor(Color.gray)
                        .padding(10)
                        .zIndex(1)
                        .allowsHitTesting(false)
                }
                
                TextEditor(text: $debouncedText)
                    .font(.input)
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.anPrimary, lineWidth: 1)
                    )
                    .onChange(of: debouncedText) { value in
                        publisher.send(value)
                    }
                    .onReceive(
                        publisher.debounce(for: .seconds(debounceSeconds),scheduler: DispatchQueue.main)) { value in
                            text = value
                        }
            }
        }
        .onAppear{
            debouncedText = text
        }
    }
}

struct ANTextFieldArea_Previews: PreviewProvider {
    static var previews: some View {
        ANTextFieldArea(text: .constant("note"), label: "Note", placeholder: "Enter your note...")
    }
}

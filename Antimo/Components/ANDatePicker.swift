//
//  ANDatePicker.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

struct ANDatePicker: View {
    @Binding var date:Date
    let label:String
    
    var body: some View {
        DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
            Text(label)
                .font(.inputLabel)
        }
    }
}

struct ANDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ANDatePicker(date: .constant(Date.now), label: "Date")
    }
}

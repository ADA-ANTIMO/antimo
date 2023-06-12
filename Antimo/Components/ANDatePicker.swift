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
    let endDate: Bool
    
    init(date: Binding<Date>, label: String, endDate: Bool = true) {
        _date = date
        self.label = label
        self.endDate = endDate
    }
    
    
    var body: some View {
        if endDate {
            DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                Text(label)
                    .font(.inputLabel)
            }
        } else {
            DatePicker(selection: $date, displayedComponents: .date) {
                Text(label)
                    .font(.inputLabel)
            }
        }
    }
}

struct ANDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ANDatePicker(date: .constant(Date.now), label: "Date", endDate: false)
    }
}

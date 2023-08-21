//
//  ANTimePicker.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

struct ANTimePicker: View {
    @Binding var time:Date
    let label:String
    
    var body: some View {
        DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
            Text(label)
                .font(.inputLabel)
        }
    }
}

struct ANTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        ANTimePicker(time: .constant(Date.now), label: "Time")
    }
}

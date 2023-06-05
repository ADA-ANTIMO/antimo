//
//  ANActivitySelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI


struct SelectorItem: View {
    let icon: String;
    let label: String;
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))

                // hack for changing color svg
                //.overlay(Rectangle().background(.red).blendMode(.overlay))
            
            Text(label)
                .font(.activitySelector)
        }
        .frame(width: 60, height: 60)
        .background(
            Color.anPrimary
        )
        .foregroundColor(Color.white)
        .cornerRadius(8)
    }
}

struct ANActivitySelector: View {
    var body: some View {
        HStack(spacing: 16) {
            SelectorItem(icon:"carrot.fill", label: "Nutrition")
            SelectorItem(icon:"cross.case.fill", label: "Medication")
            SelectorItem(icon:"tennisball.fill", label: "Exercise")
            SelectorItem(icon:"comb.fill", label: "Grooming")
            SelectorItem(icon:"heart.fill", label: "Other")
        }
    }
}

struct ANActivitySelector_Previews: PreviewProvider {
    static var previews: some View {
        ANActivitySelector()
    }
}

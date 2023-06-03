//
//  ANActivitySelector.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

struct SelectorItem: View {
    let icon: String;
    let text: String;
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            
            Text(text)
                .font(.system(size: 10))
        }
        
        .frame(width: 60, height: 60)
        .background(
            Color("PrimaryColor")
        )
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct ANActivitySelector: View {
    var body: some View {
        HStack(spacing: 16) {
            SelectorItem(icon:"carrot.fill", text: "Nutrition")
            SelectorItem(icon:"cross.case.fill", text: "Medication")
            SelectorItem(icon:"tennisball.fill", text: "Exercise")
            SelectorItem(icon:"comb.fill", text: "Grooming")
            SelectorItem(icon:"heart.fill", text: "Other")
        }
    }
}

struct ANActivitySelector_Previews: PreviewProvider {
    static var previews: some View {
        ANActivitySelector()
    }
}

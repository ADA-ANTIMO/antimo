//
//  ANActivityPicker.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
//

import SwiftUI

enum Medication: String, CaseIterable {
    case medicine = "Medicine"
    case vet = "Vet"
    case vaccine = "Vaccine"
    case vitamin = "Vitamin"
}

struct ANActivityPicker: View {
    @State var selected: Medication = .vaccine
    @State var isDropdownShown = false
    let label:String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.inputLabel)
            
            Spacer()
            
            Menu {
                ForEach(Medication.allCases, id: \.self) { activityType in
                    Button {
                        selected = activityType
                    } label: {
                        Text(activityType.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(selected.rawValue)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(
                            Color.anPrimary
                        )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .frame(maxWidth: 200)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.anPrimary)
                )
                .onTapGesture {
                    withAnimation {
                        isDropdownShown.toggle()
                    }
                }
            }
        }
    }
}

struct ANActivityPicker_Previews: PreviewProvider {
    static var previews: some View {
        ANActivityPicker(label: "Activity:")
            .padding(.horizontal)
    }
}

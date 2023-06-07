//
//  ANEventCard.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct ANEventCard: View {
    var icon: AcitivityIcons
    var title: String
    var desc: String
    var time: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ReminderIcon(icon: icon.rawValue).foregroundColor(Color.anPrimary)
            
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.eventTitle)
                    Text(desc).font(.eventContent)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                Text(time).font(.eventTime)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            Color.anPrimaryLight
        )
        .cornerRadius(8)
    }
}

struct ANEventCard_Previews: PreviewProvider {
    static var previews: some View {
        ANEventCard(icon: .exercise, title: "", desc: "", time: "")
    }
}

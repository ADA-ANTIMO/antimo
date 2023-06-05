//
//  ANBaseContainer.swift
//  Antimo
//
//  Created by Roli Bernanda on 05/06/23.
//

import SwiftUI

struct ANBaseContainer<Children: View, Toolbar: View>: View {
    let toolbar: () -> Toolbar
    let children: () -> Children
    
    var body: some View {
        VStack {
            toolbar()
            GeometryReader { geometry in
                VStack {
                    children()
                }
                .frame(height: geometry.size.height)
            }
            
        }
    }
}

//struct ANBaseContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        ANBaseContainer()
//    }
//}

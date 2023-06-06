//
//  ANBaseContainer.swift
//  Antimo
//
//  Created by Roli Bernanda on 05/06/23.
//

import SwiftUI

struct ANBaseContainer<Toolbar: View, Children: View>: View {
    let toolbar: () -> Toolbar
    let children: () -> Children
    
    init(@ViewBuilder toolbar: @escaping () -> Toolbar, @ViewBuilder children: @escaping () -> Children) {
        self.toolbar = toolbar
        self.children = children
    }
    
    var body: some View {
        VStack {
            toolbar()
            
            VStack {
                children()
            }
            
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ANBaseContainer_Previews: PreviewProvider {
    static var previews: some View {
        ANBaseContainer(toolbar: {
            Text("foo")
        }, children: {
            Text("Bar")
        })
    }
}

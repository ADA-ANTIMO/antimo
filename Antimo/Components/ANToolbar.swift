//
//  ANToolbar.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 04/06/23.
//

import SwiftUI

struct ANToolbar<Toolbar:View>: View {
    let leading: (() -> Toolbar)?
    let title: String
    let trailing: (() -> Toolbar)?
    
    init(title: String
    ) {
        self.leading = nil
        self.title = title
        self.trailing = nil
    }
    
    init(title: String, trailing: @escaping () -> Toolbar
    ) {
        self.leading = nil
        self.title = title
        self.trailing = trailing
    }
    
    init(leading: @escaping () -> Toolbar, title: String
    ) {
        self.leading = leading
        self.title = title
        self.trailing = nil
    }
    
    init(leading: @escaping () -> Toolbar,title: String, trailing: @escaping () -> Toolbar
    ) {
        self.leading = leading
        self.title = title
        self.trailing = trailing
    }
    
    var body: some View {
        VStack {
            //Toolbar Item
            //TODO: find better way to style
            Grid {
                GridRow() {
                    // TODO: find way to have grid better
                    HStack {
                        if let leading = leading {
                            leading()
                        } else {
                            Text("")
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(title)
                            .font(.screenTitle)
                    }
                    
                    HStack() {
                        Spacer()
                        
                        if let trailing = trailing {
                            trailing()
                        } else {
                            Text("")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            
            Divider()
        }
    }
}

struct ANToolbar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ANToolbar(leading: {
                Text("HIWHIWHIW")
            }, title: "Text")
            
            ANToolbar<AnyView>(title: "Text")
            
            ANToolbar(leading: {
                Text("HIWHIWHIW")
            }, title: "Text") {
                Text("djwoajdo")
            }
        }
    }
}

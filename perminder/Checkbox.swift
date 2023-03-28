//
//  Checkbox.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-28.
//

import SwiftUI

struct Checkbox: View {
    @Binding var b:Bool
    
    var body: some View {
        Button (action: {toggle()}) {
            if (b) {
                Image(systemName:"checkmark.square")
            } else {
                Image (systemName:"square")
            }
        }
    }
    
    func toggle () {
        b = !b
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(b: .constant(false))
    }
}

//
//  Checkbox.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-28.
//

import SwiftUI

// Shows a togglable textbox
struct Checkbox: View {
    @Binding var b:Bool
    var size:Int
    
    // calls this function every time the checkbox is toggled
    var funct: () -> Void
    
    var body: some View {
        Image(systemName: b ? "checkmark.circle.fill" : "circle")
            .resizable()
            .frame(width: CGFloat(size), height: CGFloat(size)).onTapGesture {
            self.b.toggle()
            self.funct()
        }
        
    }
}

#if DEBUG
struct Checkbox_Previews: PreviewProvider {
    struct CheckboxPreviewHolder: View {
        @State var checked = false
        
        var body: some View {
            Checkbox(b: $checked, size:20, funct:{})
        }
    }
    
    static var previews: some View {
        CheckboxPreviewHolder ()
    }
}
#endif

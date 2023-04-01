//
//  Checkbox.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-28.
//

import SwiftUI

struct Checkbox: View {
    @Binding var b:Bool
    var size:Int
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

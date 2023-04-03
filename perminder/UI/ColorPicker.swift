//
//  ColorPicker.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-01.
//

import SwiftUI

struct ColorPicker: View {
    @State var color:RGB
    var funct:(RGB) -> ()
    
    var body: some View {
        HStack (spacing:0) {
            Image(systemName:"square.fill").resizable().frame(width:50, height:50).padding(.trailing)
                .foregroundColor(Color(red:Double(color.r)/255.0, green:Double(color.g)/255.0, blue:Double(color.b)/255.0))
            
            Picker ("Red", selection:$color.r) {
                ForEach (0...255, id:\.self) { val in
                    Text(String(val)).tag(val)
                }
            }.pickerStyle(.wheel).frame(width:75)
                .onChange(of:color.r, perform: { val in
                    funct(color)
                })
                
            
            Picker ("Green", selection:$color.g) {
                ForEach (0...255, id:\.self) { val in
                    Text(String(val)).tag(val)
                }
            }.pickerStyle(.wheel).frame(width:75)
                .onChange(of:color.g, perform: { val in
                    funct(color)
                })
            
            Picker ("Blue", selection:$color.b) {
                ForEach (0...255, id:\.self) { val in
                    Text(String(val)).tag(val)
                }
            }.pickerStyle(.wheel).frame(width:75)
                .onChange(of:color.b, perform: { val in
                    funct(color)
                })
        }.frame(height: 100)
    }
}

#if DEBUG
struct ColorPicker_Previews: PreviewProvider {
    struct CPicker_Wrapper: View {
        @State var color:RGB = RGB(red:0, green:0, blue:0)
        
        var body: some View {
            HStack {
                ColorPicker(color:color, funct: { _ in
                    print("this doesn't do anything bc it's not in the right context")
                })
            }
        }
    }
    
    static var previews: some View {
        CPicker_Wrapper()
    }
}
#endif

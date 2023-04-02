//
//  ScheduleModifierView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-01.
//

import SwiftUI

struct ScheduleEditorView: View {
    @Binding var sc:Schedule?
    
    var body: some View {
        if sc != nil {
            if sc!.type != "daily" {
                
            }
        } else {
            Text("")
        }
    }
}

struct ScheduleModifierView_Previews: PreviewProvider {
    struct SDV_Wrapper: View {
        @State var sc:Schedule? = Daily()
        
        var body: some View {
            ScheduleEditorView(sc:$sc)
        }
    }
    
    static var previews: some View {
        SDV_Wrapper()
    }
}

//
//  DayEditorView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-02.
//

import SwiftUI

struct DayEditorView: View {
    @Binding var sch:Schedule
    var ind:Int
    
    var body: some View {
        Text(String(ind))
    }
}

#if DEBUG
struct DayEditorView_Previews: PreviewProvider {
    struct DEV_Wrapper: View {
        @State var sch:Schedule = Daily()
        
        var body: some View {
            List
            {
                DayEditorView(sch:$sch, ind:0)
            }
        }
    }
    
    static var previews: some View {
        DEV_Wrapper()
    }
}
#endif

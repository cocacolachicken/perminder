//
//  DayEditorView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-02.
//

import SwiftUI

struct DayEditorView: View {
    var daySelected:Int
    @EnvironmentObject var dat:DataManager
    @State var timeSelected:String = "0000"
    
    var body: some View {
        ForEach (dat.opt.sc.days[daySelected].times, id:\.self) { timeb in
            Text(timeb.timeAssigned)
        }
        
        TimeSelector(time:timeSelected, bind:$timeSelected)
        
        Button (action: {
            dat.opt.sc.days[daySelected].addTimeBlock(time:timeSelected)
        }, label: {
            Text ("Add time")
        })
    }
}

/*
struct DayEditorView_Previews: PreviewProvider {
    static var previews: some View {
    }
}
*/

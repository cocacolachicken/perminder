//
//  DayEditorView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-02.
//

import SwiftUI

struct DayEditorView: View {
    @Binding var daySelected:Int
    @EnvironmentObject var dat:DataManager
    @State var timeSelected:String = "0000"
    
    init (daySelected:Binding<Int>) {
        _daySelected = daySelected
    }
    
    var body: some View {
        ForEach (dat.opt.sc.days[daySelected].times, id:\.self) { timeb in
            Text("Sending at: " + formatWithoutColon(time:timeb.timeAssigned))
        }.onDelete(perform:delete)
        
        TimeSelector(time:timeSelected, bind:$timeSelected)
        
        Button (action: {
            dat.opt.sc.days[daySelected].addTimeBlock(time:timeSelected)
            dat.objectWillChange.send()
            writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
        }, label: {
            Text ("Add time")
        })
    }
    
    func delete (at offsets: IndexSet) {
        dat.opt.sc.days[daySelected].times.remove(atOffsets: offsets)
        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
    }
    
    func formatWithoutColon (time:String) -> String {
        var mutate = time
        let index = mutate.index(mutate.startIndex, offsetBy: 2)
        mutate.insert(":", at:index)
        
        return mutate
    }
}

/*
struct DayEditorView_Previews: PreviewProvider {
    static var previews: some View {
    }
}
*/

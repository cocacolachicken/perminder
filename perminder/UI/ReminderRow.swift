//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderRow: View {
    @EnvironmentObject var dat:DataManager
    var index:Int = 0
    var remind:Reminder = Reminder(n:"")
    var tags:[String] = []
    @Binding var toggle:Bool
    
    init (i:Int, r:Reminder, t:Binding<Bool>) {
        self.index = i
        self.remind = r
        self.tags = r.getTags()
        _toggle = t
    }
    
    
    var body: some View {
        
        
        HStack {
            
            VStack {
            
                Checkbox(b: $toggle, size:20, funct: {
                    if toggle {
                        dat.reminders[index].markFinished()
                    } else {
                        dat.reminders[index].markIncomplete()
                    }
                    
                    
                    writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                    
                }).padding(.top)
                
                Spacer()
                
            }
            
            VStack {
                HStack{
                    Text(remind.getName())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading).lineLimit(1)
                    Spacer()
                }
                HStack {
                    if (remind.getDue() != nil){
                        Text(formatDate(date:remind.getDue()!))
                        
                    }
                    
                    
                    
                    ForEach(tags, id:\.self) {tag in
                        Text("#\(tag)")
                            .foregroundColor(Color(red: Double(dat.tags[tag]!.getColor().r)/255.0, green: Double(dat.tags[tag]!.getColor().g)/255.0, blue: Double(dat.tags[tag]!.getColor().b)/255.0))
                    }
                    
                    if remind.getTags().count == 0 {
                        Text("")
                    }
                    
                    Spacer()
                }
            }
            
            
        }
    }
}

#if DEBUG
struct ReminderRow_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        List {
            ReminderRow(i:0, r:data.reminders[0], t:$data.reminders[0].isFinished).environmentObject(data)
            
            ReminderRow(i:1,  r:data.reminders[1], t:$data.reminders[1].isFinished).environmentObject(data)
        }
    }
}
#endif

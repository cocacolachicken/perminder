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
    @State var toggle:Bool = false
    
    init (i:Int, t:Bool, r:Reminder) {
        self.index = i
        self.toggle = t
        self.remind = r
        print(index)
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
                    ForEach(remind.getTags()) {tag in
                        Text("#" + tag.getName())
                            .foregroundColor(Color(red:Double(tag.getColor().r)/255.0, green:Double(tag.getColor().g)/255.0, blue:Double(tag.getColor().b)/255.0))
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

struct ReminderRow_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        List {
            ReminderRow(i:0, t:false, r:data.reminders[0]).environmentObject(data)
            
            ReminderRow(i:1, t:false, r:data.reminders[1]).environmentObject(data)
        }
    }
}

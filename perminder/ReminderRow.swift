//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderRow: View {
    @EnvironmentObject var dat:DataManager
    var remindID:Int
    @State var toggle:Bool
    
    
    var body: some View {
        let remind:Reminder = dat.reminderByID[remindID]!
        
        
        HStack {
            
            VStack {
            
                Checkbox(b: $toggle, size:20, funct: {
                    if toggle {
                        self.dat.markFinished(id:remindID)
                        dat.completeness[remindID]! = true;
                    } else {
                        self.dat.markIncomplete(id:remindID)
                        dat.completeness[remindID]! = false;
                    }
                    
                    dat.objectWillChange.send()
                    
                    
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
            ReminderRow(remindID:0, toggle:false).environmentObject(data)
            
                ReminderRow(remindID:3, toggle:false).environmentObject(data)
        }
    }
}

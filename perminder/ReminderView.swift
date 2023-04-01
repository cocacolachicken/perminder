//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI
import Combine

struct ReminderView: View {
    @EnvironmentObject var dat:DataManager
    @State var title:String
    @State var finished:Date?
    var remind:Reminder
    var ind:Int
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    "",
                    text:$title
                ).onChange(of:title){ newVal in
                    dat.reminders[ind].changeName(str:title)
                }.fontWeight(.semibold).font(.title)
                
                Spacer()
            }
            
            HStack {
                
                if finished != nil {
                    Text("Finished \(formatDate(date:finished!))")
                        
                } else {
                    Text("Not finished")
                }
                Spacer()
            }
            
            HStack {
                let condition = remind.getDue() != nil ? true : false
                if condition {
                    Text("Due \(formatDate(date:remind.getCreated()))")
                        
                } else {
                    Text("No due date")
                }
                Spacer()
            }
            
            HStack {
                Text("Created \(formatDate(date:remind.getCreated()))")
                Spacer()
            }
            
            HStack {
                ForEach (remind.getTags()) { tag in
                    NavigationLink {
                        TagsReminderView(tag:tag)
                    } label: {
                    Text("#" + tag.getName())
                        .foregroundColor(Color(red:Double(tag.getColor().r)/255.0, green:Double(tag.getColor().g)/255.0, blue:Double(tag.getColor().b)/255.0))
                        
                    }
                }
                Spacer()
            }
            
            HStack {
                Text(String(remind.rid))
                Spacer()
            }
                
            Spacer()
        }.navigationTitle(remind.getName()).navigationBarTitleDisplayMode(.inline)
    }
}

struct ReminderView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        NavigationStack {
            ReminderView(title:"Project due", finished: data.reminders[0].getFinished(), remind:data.reminders[0], ind:0).environmentObject(data)
        }.padding()
    }
}

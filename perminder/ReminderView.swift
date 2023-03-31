//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var dat:DataManager
    var id:Int
    
    var body: some View {
        let remind:Reminder = dat.reminderByID[id]!
        
        VStack {
            HStack {
                Text(remind.getName()).font(.title).fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                
                if dat.completeness[id]! {
                    Text("Finished \(formatDate(date:remind.getFinished()!))")
                        
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
                        TagsView(tag:tag)
                    } label: {
                    Text("#" + tag.getName())
                        .foregroundColor(Color(red:Double(tag.getColor().r)/255.0, green:Double(tag.getColor().g)/255.0, blue:Double(tag.getColor().b)/255.0))
                        
                    }
                }
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
            ReminderView(id:0).environmentObject(data)
        }.padding()
    }
}

//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderView: View {
    var remind:Reminder
    
    var body: some View {
        
        VStack {
            HStack {
                Text(remind.getName()).font(.title).fontWeight(.semibold)
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
    static var previews: some View {
        NavigationStack {
            ReminderView(remind:Reminder.example)
        }.padding()
    }
}

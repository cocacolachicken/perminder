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
                Text(remind.name).font(.title).fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("Created \(formatDate(date:remind.created))")
                Spacer()
            }
            
            HStack {
                ForEach (remind.tags) { tag in
                    Text("#" + tag.name)
                        .foregroundColor(Color(red:Double(tag.color.r)/255.0, green:Double(tag.color.g)/255.0, blue:Double(tag.color.b)/255.0))
                }
                Spacer()
            }
                
            Spacer()
        }.navigationTitle(remind.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReminderView(remind:Reminder.example)
        }.padding()
    }
}

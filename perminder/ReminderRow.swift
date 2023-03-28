//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderRow: View {
    var remind:Reminder
    
    var body: some View {
        HStack {
            VStack {
                HStack{
                    Text(remind.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    ForEach(remind.tags) {tag in
                        Text("#" + tag.name)
                            .foregroundColor(Color(red:Double(tag.color.r)/255.0, green:Double(tag.color.g)/255.0, blue:Double(tag.color.b)/255.0))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct ReminderRow_Previews: PreviewProvider {
    static var previews: some View {
        ReminderRow(remind: Reminder.example)
    }
}

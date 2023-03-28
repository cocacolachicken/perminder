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
            Text("Created \(formatDate(date:remind.created))")
                
            Spacer()
        }.navigationTitle(remind.name).navigationBarTitleDisplayMode(.large)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReminderView(remind:Reminder.example)
        }
    }
}

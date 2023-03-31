//
//  AddReminderBar.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-28.
//

import SwiftUI

struct AddReminderBar: View {
    @State var search: String = ""
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        HStack {
            TextField(text:$search, prompt:Text("Add new reminder")) {
                Text("Search")
            }
            
            Button (action: {
                if search != "" {
                    dat.addReminder(n:search)
                    search = ""
                    
                }
            }) {
                Image(systemName:"square.and.pencil")
            }.buttonStyle(.bordered)
        }
    }
}

struct AddReminderBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                AddReminderBar()
            }
        }
    }
}

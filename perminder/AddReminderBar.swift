//
//  AddReminderBar.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-28.
//

import SwiftUI

struct AddReminderBar: View {
    @State var search: String = ""
    
    var body: some View {
        
        
        List {
            
            VStack {
                
                
                TextField(text:$search, prompt:Text("Add new reminder")) {
                    Text("Search")
                }
                Button (action: {
                }) {
                    Image(systemName:"square.and.pencil")
                }.buttonStyle(.bordered)
            }
            
        }
    }
}

struct AddReminderBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddReminderBar()
            
        }
    }
}

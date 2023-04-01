//
//  TagsView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct TagsReminderView: View {
    @EnvironmentObject var dat:DataManager
    
    var tag:Tag
    
    init(tag:Tag) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color(red:Double(tag.getColor().r)/255.0, green:Double(tag.getColor().g)/255.0, blue:Double(tag.getColor().b)/255.0))]
        self.tag = tag
    }
    
    var body: some View {
        VStack {
            List {
                Section ("Reminders in \(tag.getName())") {
                    ForEach(["", ""], id: \.self) { remind in
                    }
                }
            }
        }.navigationTitle(tag.getName()).navigationBarTitleDisplayMode(.inline)
    }
}

struct TagsReminderView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    
    static var previews: some View {
        NavigationStack {
            TagsReminderView(tag:Tag.example).environmentObject(data)
            
        }
    }
}
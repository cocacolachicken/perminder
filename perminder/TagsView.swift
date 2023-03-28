//
//  TagsView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct TagsView: View {
    var tag:Tag
    
    init(tag:Tag) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color(red:Double(tag.color.r)/255.0, green:Double(tag.color.g)/255.0, blue:Double(tag.color.b)/255.0))]
        self.tag = tag
    }
    
    var body: some View {
        VStack {
            
            
            Spacer()
        }.navigationTitle(tag.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TagsView(tag:Tag.example)
            
        }
    }
}

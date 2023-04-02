//
//  TagRow.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-31.
//

import SwiftUI

struct TagRow: View {
    var t:Tag
    
    var body: some View {
        HStack {
            Text("#\(t.getName())")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(red:Double(t.getColor().r)/255.0, green:Double(t.getColor().g)/255.0, blue:Double(t.getColor().b)/255.0))
            Spacer()
            
        }
    }
}

#if DEBUG
struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        TagRow(t: Tag(n:"tag", c:[255, 0, 255]))
    }
}
#endif

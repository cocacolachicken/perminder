//
//  TagRow.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-31.
//

import SwiftUI

struct TagRow: View {
    @EnvironmentObject var dat:DataManager
    var t:String
    
    var body: some View {
        HStack {
            Text("#\(t)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(red:Double(dat.tags[t]!.getColor().r)/255.0, green:Double(dat.tags[t]!.getColor().g)/255.0, blue:Double(dat.tags[t]!.getColor().b)/255.0))
            Spacer()
            
        }
    }
}

#if DEBUG
struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Text("please look somewhere else")
        }
    }
}
#endif

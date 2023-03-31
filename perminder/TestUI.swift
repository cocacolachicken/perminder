//
//  TestUI.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct TestUI: View {
    var body: some View {
        
        VStack {
            
            let dat:CodableDataManager = Bundle.main.decode(file:"testdata.json")
            
            let dataaaaaa = DataManager(dat)
            
            let str:String = Bundle.main.encode(encode:dataaaaaa.getCodableVersion())
        
        Text (str)
            
        }
    }
}

struct TestUI_Previews: PreviewProvider {
    static var previews: some View {
        TestUI()
    }
}

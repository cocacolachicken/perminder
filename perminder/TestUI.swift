//
//  TestUI.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct TestUI: View {
    var body: some View {
        Text(Bundle.main.encode(encode:Date()))
    }
}

struct TestUI_Previews: PreviewProvider {
    static var previews: some View {
        TestUI()
    }
}

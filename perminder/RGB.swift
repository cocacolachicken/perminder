//
//  RGB.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import Foundation

class RGB {
    var r, g, b:Int
    
    func toArray () -> [Int] {
        [r, g, b]
    }
    
    init (red:Int, green:Int, blue:Int) { // Represents a given color in RGB form; 0-255
        r = red
        g = green
        b = blue
    }
}

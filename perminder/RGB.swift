//
//  RGB.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import Foundation

/// Represents a color in RGB format, with numbers for each base color ranging from 0-255

class RGB: Hashable, Equatable {
    static func == (lhs: RGB, rhs: RGB) -> Bool {
        return lhs.toArray() == rhs.toArray()
    }
    
    var r, g, b:Int
    
    func toArray () -> [Int] {
        [r, g, b]
    }
    
    func hash (into hasher:inout Hasher) {
        hasher.combine(r)
        hasher.combine(g)
        hasher.combine(b)
    }
    
    
    ///Creates an instance of RGB
    ///
    /// - Parameters
    ///    - r: the color **red**
    ///    - g: the color **green**
    ///    - b: the color **blue**
    init (red:Int, green:Int, blue:Int) { // Represents a given color in RGB form; 0-255
        r = red
        g = green
        b = blue
    }
}

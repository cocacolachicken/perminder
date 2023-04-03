//
//  RGB.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import Foundation

/// Represents a color in RGB format, with numbers for each base color ranging from 0-255

struct RGB: Hashable, Equatable {
    static func == (lhs: RGB, rhs: RGB) -> Bool {
        return lhs.toArray() == rhs.toArray()
    }
    
    var r, g, b:Int
    
    /**
     * Turns the three color ints into a single array
     * @return a array with the RGB values
     */
    func toArray () -> [Int] {
        [r, g, b]
    }
    
    /**
     * Hashes the 3 colors with a hasher
     * @Param Hasher a hasher passed into the function to combine the 3 color values
     */
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

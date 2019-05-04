//
//  UIColor.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     Creates a color from an hex int.
     
     - parameter hexString: A hexa-decimal color number representation.
     */
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    struct Venados {
        struct Green {
            static let dark = UIColor(hex: 0x00762b)
            static let light = UIColor(hex: 0xf8bd00)
        }
        
        static let white = UIColor.white
        static let black = UIColor.black
    }
    
}

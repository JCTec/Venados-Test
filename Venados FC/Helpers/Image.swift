//
//  Image.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Deja una UIImageView con una imagen redonda.
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
    
}

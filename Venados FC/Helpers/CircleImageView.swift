//
//  CircleImageView.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

/// Clase que hereda de UIImageView y aplica setRounded() dejando la imagen redonda.
class CircleImageView: UIImageView {
    
    
    override func awakeFromNib() {
        self.setRounded()
    }
}

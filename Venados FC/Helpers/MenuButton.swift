//
//  MenuButton.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

/// Boton usado en el Menu.
class MenuButton: UIButton {
    
    override func awakeFromNib() {
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
}

//
//  CircleImageView.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

class CircleImageView: UIImageView {
    override func awakeFromNib() {
        self.setRounded()
    }
}

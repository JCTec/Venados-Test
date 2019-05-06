//
//  CGFloat.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/5/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    /// Regresa self menos el CGFloat dado hasta el punto de 0.0.
    ///
    /// - Parameter value: Valor a restar.
    /// - Returns: El CGFloat final (< self y >= 0.0)
    func minusOrZero(_ value: CGFloat) -> CGFloat{
        var toReturn = self - value
        if (toReturn <= 0.0){
            toReturn = 0.0
        }
        return toReturn
    }
    
}

//
//  CollectionView.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    /// Agrega un mensaje a un CollectionView vacío.
    ///
    /// - Parameters:
    ///   - message: Mensaje a Agregar
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    /// Regresa una CollectionView a su estado original despues de usar setEmptyMessage(_ message: String)
    func restore() {
        self.backgroundView = nil
    }
    
}



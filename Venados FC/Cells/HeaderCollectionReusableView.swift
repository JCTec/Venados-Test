//
//  HeaderCollectionReusableView.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var month: UILabel!
    
    override func awakeFromNib() {
        NSLayoutConstraint.activate([
                self.month.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                self.topAnchor.constraint(equalTo: self.month.topAnchor, constant: 0.0),
                self.bottomAnchor.constraint(equalTo: self.month.bottomAnchor, constant: 0.0)
            
            ])
        
        self.month.textColor = UIColor.white
    }
    
}

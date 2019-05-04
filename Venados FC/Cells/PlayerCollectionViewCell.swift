//
//  PlayerCollectionViewCell.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePlayer: CircleImageView!
    @IBOutlet weak var centerLabel: UILabel!
    
    override func awakeFromNib() {
        self.centerLabel.numberOfLines = 0
    }
    
    func reuse(){
        self.imagePlayer.image = #imageLiteral(resourceName: "venados")
        self.imagePlayer.backgroundColor = UIColor.Venados.Green.light
    }
    
    func setImage(with URL: URL){
        self.setURL(URL, for: self.imagePlayer)
        self.imagePlayer.backgroundColor = UIColor.clear
    }
    
    private func setURL(_ url: URL, for view: UIImageView){
        
        view.startAnimating()
        
        view.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "venados"), options: [.preloadAllFrames], progress: .none) { (image, error, cahce, url) in
            
            if(error != nil){
                print("-----------ERROR-----------")
                print(error!)
                print("-----------ERROR-----------")
            }
            
            view.stopAnimating()
            view.clipsToBounds = true
        }
        
    }
}

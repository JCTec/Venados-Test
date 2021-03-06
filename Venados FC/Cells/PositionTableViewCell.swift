//
//  PositionTableViewCell.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit
import SDWebImage

class PositionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jj: UILabel!
    @IBOutlet weak var dg: UILabel!
    @IBOutlet weak var pts: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.Venados.Green.light
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Asigna un url de imagen a la imagen del equipo.
    ///
    /// - Parameter URL: URL a Agregar.
    func setImage(url: URL){
        self.setURL(url, for: self.teamImage)
    }
    
    /// Asigna un url de imagen a una UIImage View.
    ///
    /// - Parameter URL: URL a Agregar, Viw a la cual agregar la imagen.
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

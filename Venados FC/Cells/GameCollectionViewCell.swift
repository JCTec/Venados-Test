//
//  GameCollectionViewCell.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit
import SDWebImage

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var calendarImage: UIImageView!
    @IBOutlet weak var calendarLabel: UILabel!
    
    @IBOutlet weak var leftTeamImage: UIImageView!
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var rightTeamImage: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        self.calendarImage.tintColor = UIColor.white

    }
    
    func setValues(for game: Game){
        let date = Date.getFromProfessional(str: game.datetime)
        
        self.calendarLabel.text = date.getVenadosDate()
        
        if(game.local){
            self.leftLabel.text = "Venados F.C."
            self.rightLabel.text = game.opponent
            
            self.setImageForRight(with: game.opponent_image)
            self.leftTeamImage.image = #imageLiteral(resourceName: "venados")
        }else{
            self.leftLabel.text = game.opponent
            self.rightLabel.text = "Venados F.C."
            
            self.setImageForLeft(with: game.opponent_image)
            self.rightTeamImage.image = #imageLiteral(resourceName: "venados")

        }
        
        self.calendarImage.tintColor = UIColor.white
        self.calendarLabel.numberOfLines = 0
        self.score.text = "\(game.home_score ?? 0) - \(game.away_score ?? 0)"
    }
    
    func setImageForRight(with URL: URL){
        self.setURL(URL, for: self.rightTeamImage)

    }
    
    func setImageForLeft(with URL: URL){
        self.setURL(URL, for: self.leftTeamImage)
    }
    
    func setURL(_ url: URL, for view: UIImageView){
        
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
    
    /*
     
     struct Game: Decodable {
         var local: Bool!
         var opponent: String!
         var opponent_image: String!
         var datetime: String!
         var league: String!
         var image: String!
         var home_score: Int!
         var away_score: Int!
     }
 
 */
}

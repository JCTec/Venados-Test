//
//  Dictionary.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func getGamesFrom(index i:Int) -> [Game]{
        return self[Array(self.keys)[i]] as! [Game]
    }
    
    func getStringFrom(index i:Int) -> String{
        return self[Array(self.keys)[i]] as! String
    }
    
    func getIntFrom(index i:Int) -> Int{
        return self[Array(self.keys)[i]] as! Int
    }
}

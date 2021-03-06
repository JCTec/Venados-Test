//
//  Dictionary.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// Regresa un arreglo de Juegos de un dictionario tipo Dictionary<String,[Game]>.
    ///
    /// - Parameter i: Index a regresar.
    /// - Returns: Arreglo de Juegos.
    func getGamesFrom(index i:Int) -> [Game]{
        return self[Array(self.keys)[i]] as! [Game]
    }
    
    /// Regresa un String de un dictionario tipo Dictionary<String,String>.
    ///
    /// - Parameter i: Index a regresar.
    /// - Returns: String en el index mandado.
    func getStringFrom(index i:Int) -> String{
        return self[Array(self.keys)[i]] as! String
    }
    
    /// Regresa un Int de un dictionario tipo Dictionary<String,Int>.
    ///
    /// - Parameter i: Index a regresar.
    /// - Returns: Int en el index mandado.
    func getIntFrom(index i:Int) -> Int{
        return self[Array(self.keys)[i]] as! Int
    }
    
    /// Limpia el request dejando solo los de la liga deseada
    ///
    /// - Parameter str: Liga a elegir.
    /// - Returns: Dictionario filtrado.
    func just(_ str: String) -> Dictionary<String, [Game]>{
        
        var dic: Dictionary<String, [Game]> = Dictionary<String, [Game]>()
        
        for (key , value) in self{
            
            if let data = value as? [Game] {
                
                guard let keyToUse = key as? String else { break }

                var newArray = [Game]()
                
                for game in data{
                    if game.league == str {
                        newArray.append(game)
                    }
                }
                
                dic[keyToUse] = newArray
            }
            
        }
        
        return dic
    }
}

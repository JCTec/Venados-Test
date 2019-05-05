//
//  Game.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

class GameManager {
    static var sharedInstance = GameManager()
    
    private init() {
        print("Game Instance")
    }
    
    private var games = [Game]()
    private var gamesInOrder = Dictionary<String, [Game]>()

    /// Regresa los juegos el singleton.
    ///
    /// - Returns: Array de Juegos
    func getGames() -> [Game]{
        return self.games
    }
    
    /// Regresa los juegos el singleton en orden.
    ///
    /// - Returns: Array de Juegos
    func getGamesInOrder() -> Dictionary<String, [Game]>{
        return self.gamesInOrder
    }
    
    
    /// Actualiza el Singleton.
    ///
    /// - Parameters:
    ///   - order: Los datos se guardan en orden.
    ///   - completed: Completition Block.
    func refresh(order: Bool, completed: @escaping (Result<[Game], Error>) -> ()){
        
        let urlStr = "\(Base_URL)/api/games"
        guard let url = URL(string: urlStr) else { return }
        
        var urlRequest = URLRequest(url: url, cachePolicy:
            .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            if let err = error {
                completed(.failure(err))
                return
            }
            
            do{
                try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let games = try JSONDecoder().decode(gamesRequest.self, from: data!)
                self.games.removeAll()
                
                if(order){
                    var gamesToAdd = Dictionary<String, [Game]>()
                    
                    for game in games.data.games{
                        let dateKey = Date.getFromProfessional(str: game.datetime).month
                        
                        if (gamesToAdd[dateKey] == nil){
                            gamesToAdd[dateKey] = [Game]()
                        }
                        
                        gamesToAdd[dateKey]?.append(game)
                    }
                    
                    self.gamesInOrder = gamesToAdd
                }
                
                self.games = games.data.games

                completed(.success(games.data.games))
            }catch let jsonError {
                completed(.failure(jsonError))
            }
            
        }.resume()
    }
}

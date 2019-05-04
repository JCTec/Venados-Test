//
//  Player.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

class Player {
    static var sharedInstance = Player()
    
    private init() {
        print("Player Instance")
    }
    
    private var team: Team! = Team()
    
    func removeAll(){
        self.team.centers.removeAll()
        self.team.coaches.removeAll()
        self.team.defenses.removeAll()
        self.team.forwards.removeAll()
        self.team.goalkeepers.removeAll()
    }
    
    func getTeam() -> Team{
        return self.team
    }
    
    func refresh(completed: @escaping (Result<Team, Error>) -> ()){
        
        let urlStr = "\(Base_URL)/api/players"
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
                let players = try JSONDecoder().decode(playerRequest.self, from: data!)
                
                self.removeAll()
                
                self.team = players.data.team
                
                completed(.success(players.data.team))
            }catch let jsonError {
                completed(.failure(jsonError))
            }
            
            }.resume()
    }
}


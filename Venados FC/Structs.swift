//
//  Structs.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

let Base_URL = "https://venados.dacodes.mx"

struct playerRequest: Decodable{
    var success: Bool!
    var data: dataPlayers!
}

struct dataPlayers: Decodable{
    var team: Team!
    var code: Int!
}

struct Person: Decodable{
    var name: String!
    var first_surname: String!
    var second_surname: String!
    var birthday: String!
    var birth_place: String!
    var weight: Double!
    var height: Double!
    var position: String!
    var number: Int!
    var position_short: String!
    var last_team: String!
    var image: URL!
    var role: String!
    var role_short: String!
}

class Team: Decodable{
    var coaches: [Person]
    var goalkeepers: [Person]
    var centers: [Person]
    var defenses: [Person]
    var forwards: [Person]

    let count = 5
    
    init() {
        self.forwards = [Person]()
        self.centers = [Person]()
        self.defenses = [Person]()
        self.goalkeepers = [Person]()
        self.coaches = [Person]()
    }
    
    func removeAll(){
        self.coaches.removeAll()
        self.goalkeepers.removeAll()
        self.centers.removeAll()
        self.defenses.removeAll()
        self.forwards.removeAll()
    }
    
    func get(section index: Int) -> [Person]{
        
        switch index {
            case 0:
                return self.coaches
            
            case 1:
                return self.goalkeepers
            
            case 2:
                return self.centers
            
            case 3:
                return self.defenses
            
            case 4:
                return self.forwards
            
            default:
                return [Person]()
        }
        
    }
}

struct statisticRequest: Decodable{
    var success: Bool!
    var data: dataStatistics!
}

struct dataStatistics: Decodable{
    var statistics: [Statistic]
    var code: Int!
}

struct Statistic: Decodable{
    var position: Int!
    var image: URL!
    var team: String!
    var games: Int!
    var win: Int!
    var loss: Int!
    var tie: Int!
    var f_goals: Int!
    var a_goals: Int!
    var score_diff: Int!
    var points: Int!
    var efec: String!
    
}

struct gamesRequest: Decodable {
    var success: Bool!
    var data: data!
}

struct Game: Decodable {
    var local: Bool!
    var opponent: String!
    var opponent_image: URL!
    var datetime: String!
    var league: String!
    var image: String!
    var home_score: Int!
    var away_score: Int!
}

struct data: Decodable{
    var games: [Game]
    var code: Int!
}

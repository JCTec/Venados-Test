//
//  Structs.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

struct Games: Decodable {
    var success: Bool!
    var code: Int!
    var data: data!
}

struct StatisticRequest: Decodable {
    var success: Bool!
    var code: Int!
    var data: dataStatistics!
}

struct dataStatistics: Decodable{
    var statistics: [Statistic]
}

struct data: Decodable{
    var games: [Game]
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
/*

 {
     "position": 1,
     "image": "https://s3.amazonaws.com/lmxwebsite/docs/archdgtl/AfldDrct/logos64x64/11220/11220.png",
     "team": "Club Atlético de San Luis",
     "games": 14,
     "win": 7,
     "loss": 7,
     "tie": 0,
     "f_goals": 22,
     "a_goals": 11,
     "score_diff": 11,
     "points": 28,
     "efec": null
 }
 */

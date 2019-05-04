//
//  Statistics.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

class Statistics {
    static var sharedInstance = Statistics()
    
    private init() {
        print("Statistics Instance")
    }
    
    private var statistics = [Statistic]()
    
    func getStatistics() -> [Statistic]{
        return self.statistics
    }
    
    func refresh(completed: @escaping (Result<[Statistic], Error>) -> ()){
        
        let urlStr = "\(Base_URL)/api/statistics"
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
                let statistics = try JSONDecoder().decode(StatisticRequest.self, from: data!)
                
                self.statistics.removeAll()
                self.statistics = statistics.data.statistics
                
                completed(.success(statistics.data.statistics))
            }catch let jsonError {
                completed(.failure(jsonError))
            }
            
            }.resume()
    }
}


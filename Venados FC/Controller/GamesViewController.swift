//
//  GamesViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/1/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var statisticsCellID = "statisticsCell"
    
    var statistics = [Statistic]()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refreshControl.addTarget(self, action: #selector(self.reload), for: .valueChanged)
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 18)
        ]
        
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Descargando Lista...", attributes: strokeTextAttributes)
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        self.refreshControl.beginRefreshing()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func reload(){
        Statistics.sharedInstance.refresh { (result) in
            switch result {
                case .success(let statistics):
                    print("Success")
                    self.statistics.removeAll()
                    self.statistics = statistics
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }

                case .failure(let error):
                    print("Failure: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.statistics.count == 0){
            self.tableView.setEmptyView(title: "", message: "No hay Informacion")
        }else{
            self.tableView.restore()
        }
        
        return self.statistics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.statisticsCellID) as! PositionTableViewCell
        
        cell.selectionStyle = .none

        cell.position.text = "\(self.statistics[indexPath.row].position ?? 0)"
        cell.name.text = "\(self.statistics[indexPath.row].team ?? "Venados F.C.")"
        cell.jj.text = "\(self.statistics[indexPath.row].games ?? 0)"
        cell.dg.text = "\(self.statistics[indexPath.row].score_diff ?? 0)"
        cell.pts.text = "\(self.statistics[indexPath.row].points ?? 0)"
        cell.setImage(url: self.statistics[indexPath.row].image)
        
        return cell
        
    }
    
    
}

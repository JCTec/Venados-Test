//
//  HomeViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/1/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var copaMXB: UIButton!
    @IBOutlet weak var ascensoMXB: UIButton!
    @IBOutlet weak var ascensoMXView: UIView!
    @IBOutlet weak var copaMXView: UIView!
    
    var games: Dictionary<String, [Game]>!

    private let gameCellID = "gameCell"
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.copaMXView.addBorders(edges: [.bottom, .top, .left], color: UIColor.Venados.black, inset: 0.0, thickness: 1.0)
        
        self.ascensoMXView.addBorders(edges: .all, color: UIColor.Venados.black, inset: 0.0, thickness: 1.0)
        
        self.ascensoMXB.setTitleColor(UIColor.black, for: .normal)
        self.copaMXB.setTitleColor(UIColor.black, for: .normal)
        
        self.games = Dictionary<String, [Game]>()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        self.refreshControl.addTarget(self, action: #selector(self.reload), for: .valueChanged)
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 18)
        ]
        
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Descargando Partidos...", attributes: strokeTextAttributes)
        
        if #available(iOS 10.0, *) {
            self.collectionView.refreshControl = refreshControl
        } else {
            self.collectionView.addSubview(refreshControl)
        }
        
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
        GameManager.sharedInstance.refresh(order: true) { (result) in
            switch result {
                case .success( _):
                    print("Success")
                    self.games.removeAll()
                    self.games = GameManager.sharedInstance.getGamesInOrder()
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                    }

                case .failure(let error):
                    print("Failure: \(error)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.getGamesFrom(index: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderCollectionReusableView
        
        headerView?.month.text = Array(self.games.keys)[indexPath.section].uppercased()
        
        return headerView!
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.gameCellID, for: indexPath) as! GameCollectionViewCell
        
        cell.setValues(for: self.games.getGamesFrom(index: indexPath.section)[indexPath.row])
                
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if(self.games.count == 0){
            self.collectionView.setEmptyMessage("No hay partidos que mostrar :(")
        }else{
            self.collectionView.restore()
        }
        
        return self.games.count
    }

}







//
//  PlayersViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let nib = "PlayerCell"
    let nibCellID = "playerCell"
    
    var containerController: ContainerViewController!
    
    private var team = Team()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.titleLabel.text = "Jugadores"
        
        self.collectionView.register(nib.loadNib(), forCellWithReuseIdentifier: self.nibCellID)
        
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
        Player.sharedInstance.refresh { (result) in
            switch result {
                case .success(let team):
                    print("Success")
                    self.team.removeAll()
                    self.team = team
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                    }

                case .failure(let error):
                    print("Failure: \(error)")
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if(self.team.count == 0){
            self.collectionView.setEmptyMessage("No hay información.")
        }else{
            self.collectionView.restore()
        }
        
        return self.team.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.team.get(section: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let info: InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "info") as? InfoViewController?)! else { return }
        
        info.modalPresentationStyle = .overCurrentContext
        
        info.person = self.team.get(section: indexPath.section)[indexPath.row]
        
        self.containerController.present(view: info, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.nibCellID, for: indexPath) as! PlayerCollectionViewCell
        
        cell.reuse()
        
        let player = self.team.get(section: indexPath.section)[indexPath.row]
        
        cell.centerLabel.text = "\(player.name ?? "Error") \n \(player.position ?? player.role_short ?? "Error")"
        cell.setImage(with: player.image)
        
        return cell
    }
    
}

extension PlayersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 190)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

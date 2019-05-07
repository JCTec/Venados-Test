//
//  HomeViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/1/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var venadosImage: UIImageView!
    @IBOutlet weak var lowerConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var copaMXB: UIButton!
    @IBOutlet weak var ascensoMXB: UIButton!
    @IBOutlet weak var ascensoMXView: UIView!
    @IBOutlet weak var copaMXView: UIView!
    
    var games: Dictionary<String, [Game]>!
    
    var containerController: ContainerViewController!
    
    var copa = "Copa MX"

    private let gameCellID = "gameCell"
    private var loding = true
    private var startAutoFocus = false
    
    private lazy var indicator : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .whiteLarge)
        
        loading.sizeToFit()
        loading.color = UIColor.white
        loading.style = .whiteLarge
        loading.hidesWhenStopped = true
        
        loading.center = self.collectionView.center
        
        self.collectionView.backgroundView = loading
        self.collectionView.bringSubviewToFront(loading)
        
        return loading
    }()
    
    private var safeData = Dictionary<String, [Game]>()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.setNormal()
    }
    
    func setUpViews(){
        self.copaMXView.addBorders(edges: [.bottom, .top, .left], color: UIColor.Venados.black, inset: 0.0, thickness: 1.0)
        
        self.ascensoMXView.addBorders(edges: .all, color: UIColor.Venados.black, inset: 0.0, thickness: 1.0)
        
        self.ascensoMXB.setTitleColor(UIColor.black, for: .normal)
        self.copaMXB.setTitleColor(UIColor.black, for: .normal)
        
        self.games = Dictionary<String, [Game]>()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.bounces = false
        self.collectionView.contentOffset = CGPoint.zero

        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        self.refreshControl.addTarget(self, action: #selector(self.reload), for: .valueChanged)
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor : UIColor.white,
            .foregroundColor : UIColor.white,
            .strokeWidth : 0.0,
            .font : UIFont.boldSystemFont(ofSize: 20)
        ]
        
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Descargando Partidos...", attributes: strokeTextAttributes)
        
        self.collectionView.refreshControl = refreshControl
        
        let copaMX = UITapGestureRecognizer(target: self, action: #selector(self.copaMX))
        let ascenso = UITapGestureRecognizer(target: self, action: #selector(self.ascenso))

        self.copaMXView.isUserInteractionEnabled = true
        self.copaMXView.addGestureRecognizer(copaMX)
        
        self.ascensoMXView.isUserInteractionEnabled = true
        self.ascensoMXView.addGestureRecognizer(ascenso)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.reload(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func reload(_ first: Bool = false){
        self.startAutoFocus = false
        self.setNormal()
        self.loding = true
        self.collectionView.restore()
        
        if(first){
            self.indicator.startAnimating()
        }
        
        GameManager.sharedInstance.refresh(order: true) { (result) in
            switch result {
                case .success( _):
                    print("Success")
                    self.games.removeAll()
                    self.safeData.removeAll()
                    self.safeData = GameManager.sharedInstance.getGamesInOrder()
                    self.games = self.safeData.just(self.copa)
                    
                    DispatchQueue.main.async {
                        self.loding = false
                        self.collectionView.reloadData()
                        self.startAutoFocus = true
                        self.collectionView.contentOffset = CGPoint.zero
                        if(!first){
                            self.refreshControl.endRefreshing()
                        }else{
                            self.indicator.stopAnimating()
                        }
                        
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
    
    func setNormal(){
        self.topConstraint.constant = 50.0
        self.lowerConstraint.constant = 50.0
        self.height.constant = 150.0
    }
    
    func consMinus(_ value: CGFloat, slowerBy: CGFloat){
        
        if(self.startAutoFocus){
            
            let valueToUse: CGFloat = (value * slowerBy)
            
            self.topConstraint.constant = CGFloat(50.0).minusOrZero(valueToUse)
            self.lowerConstraint.constant = CGFloat(50.0).minusOrZero(valueToUse)
            
            self.height.constant = CGFloat(150.0).minusOrZero(valueToUse)
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        if(scrollView.contentOffset.y >= 0.0){
            self.consMinus(scrollView.contentOffset.y, slowerBy: 0.5)
        }
        
    }
    
    func refresh (sender:AnyObject)
    {
        print("Refresh")
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("TOP")
        print(scrollView.contentOffset.y)
        
        self.setNormal()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.gameCellID, for: indexPath) as! GameCollectionViewCell
        
        let game = self.games.getGamesFrom(index: indexPath.section)[indexPath.row]
        
        cell.game = game
        cell.parent = self.containerController
        cell.setValues(for: game)
                
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if(!self.loding){
            if(self.games.count == 0){
                self.collectionView.setEmptyMessage("No hay partidos que mostrar :(")
            }else{
                self.collectionView.restore()
            }
        }
                
        return self.games.count
    }

    @IBAction func didSelectCopaMX(_ sender: Any) {
        self.copaMX()

    }
    
    @IBAction func didSelectAscenso(_ sender: Any) {
        self.ascenso()
    }
    
    @objc func ascenso(){
        self.copa = "Ascenso MX"
        self.reloadLocal()
    }
    
    @objc func copaMX(){
        self.copa = "Copa MX"
        self.reloadLocal()
    }
    
    func reloadLocal(){
        self.games = self.safeData.just(self.copa)
        self.collectionView.reloadData()
    }
}






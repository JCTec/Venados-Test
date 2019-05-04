//
//  ContainerViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit
import SideMenu

class ContainerViewController: UIViewController, MenuViewControllerDelegate {

    @IBOutlet weak var edge: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var homeButton: UIButton!
    
        
    fileprivate func add(asChildViewController viewController: UIViewController) {
        // Add Child View as Subview
        self.container.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }

    private let menuLeftNavigationController: UISideMenuNavigationController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        
        return viewController
    }()
    
    private lazy var menuVC: HomeViewController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        
        self.add(asChildViewController: viewController)

       return viewController
    }()
    
    private lazy var gamesVC: GamesViewController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "games") as! GamesViewController

        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    private lazy var statisticsVC: PlayersViewController! = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "statistics") as! PlayersViewController
        
        viewController.containerController = self
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuLeftNavigationController = self.menuLeftNavigationController
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.homeButton)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.edge)
    }
    
    func didSelectMenu() {
        print("Home Menu")
        self.dismiss(animated: true, completion: nil)
        self.container.bringSubviewToFront(self.menuVC.view)
    }
    
    func didSelectGames() {
        print("Games Menu")
        self.dismiss(animated: true, completion: nil)
        self.container.bringSubviewToFront(self.gamesVC.view)

    }
    
    func didSelectStatistics() {
        print("Statistics Menu")
        self.dismiss(animated: true, completion: nil)
        self.container.bringSubviewToFront(self.statisticsVC.view)
    }
    
    @IBAction func didSelectHomeButton(_ sender: Any) {
        (SideMenuManager.default.menuLeftNavigationController!.topViewController as! MenuViewController).delegate = self

        self.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
    }
    
}

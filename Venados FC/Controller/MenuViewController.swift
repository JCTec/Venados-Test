//
//  MenuViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectMenu()
    func didSelectGames()
    func didSelectStatistics()
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var home: MenuButton!
    @IBOutlet weak var games: MenuButton!
    @IBOutlet weak var statistics: MenuButton!
    
    weak var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func didSelectMenu(_ sender: Any) {
        self.delegate?.didSelectMenu()

    }
    
    @IBAction func didSelectStatistics(_ sender: Any) {
        self.delegate?.didSelectStatistics()

    }
    
    @IBAction func didSelectGames(_ sender: Any) {
        self.delegate?.didSelectGames()

    }
    
}

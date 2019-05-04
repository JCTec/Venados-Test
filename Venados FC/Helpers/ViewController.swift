//
//  ViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func present(view vc: UIViewController, animated: Bool!){
        self.present(vc, animated: animated, completion: nil)
    }
}

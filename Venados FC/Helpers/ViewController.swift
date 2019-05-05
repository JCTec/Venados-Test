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
    /// Presenta un UIViewController por mdeio de otro UIViewController
    ///
    /// - Parameters:
    ///   - vc: UIViewController a agregar
    ///   - animated: Sera Animado o No?
    func present(view vc: UIViewController, animated: Bool!){
        self.present(vc, animated: animated, completion: nil)
    }
}

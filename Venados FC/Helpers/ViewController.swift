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
    
    /// Pasa una alerta a un UIViewController. (Con Opciones)
    ///
    /// - Parameters:
    ///   - title: Título del mensaje.
    ///   - message: Mensaje para mostrar.
    ///   - options: Opciones de la alerta.
    ///   - completion: Completition Block.
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Pasa una alerta a un UIViewController.
    ///
    /// - Parameters:
    ///   - message: Mensaje para mostrar.
    ///   - title: Título del mensaje.
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

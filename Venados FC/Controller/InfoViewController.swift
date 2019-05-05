//
//  InfoViewController.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/3/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lastTeam: UILabel!
    @IBOutlet weak var tittleLastTeam: UILabel!
    @IBOutlet weak var peso: UILabel!
    @IBOutlet weak var altura: UILabel!
    @IBOutlet weak var tittleAltura: UILabel!
    @IBOutlet weak var tittlePeso: UILabel!
    @IBOutlet weak var tittleBirthplace: UILabel!
    @IBOutlet weak var birthplace: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var titleBirthdate: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var imagePlayer: CircleImageView!
    @IBOutlet weak var nameTittle: UILabel!
    @IBOutlet weak var exit: UILabel!
    @IBOutlet weak var brownView: UIView!
    @IBOutlet weak var backView: UIView!
    
    var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissMe))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.dismissMe))

        self.exit.isUserInteractionEnabled = true
        self.exit.addGestureRecognizer(tap)
        
        self.backView.addGestureRecognizer(tap2)
        
        self.myView.layer.cornerRadius = 15
        
        self.scrollView.contentSize = CGSize(width: self.myView.frame.width, height: 600)
        self.scrollView.layer.cornerRadius = 15
        self.brownView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissMe(){
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.namePlayer.text = self.person.name ?? "Error"
        self.position.text = self.person.position ?? self.person.role ?? "Error"
        self.birthdate.text = Date.getFromProfessional(str: self.person.birthday).getDisplayDate()
        self.birthplace.text = self.person.birth_place ?? "Error"
        
        if(self.person.weight != nil){
            self.peso.text = "\(self.person.weight ?? 0.0) Kg"
        }else{
            self.peso.text = "---"
        }
        
        if(self.person.height != nil){
            self.altura.text = "\(self.person.height ?? 0.0) Kg"
        }else{
            self.altura.text = "---"
        }
        
        self.lastTeam.text = self.person.last_team ?? "---"
        
    }
    
    /// Asigna self.person.image que contiene un url de imagen a la imagen del jugador.
    ///
    ///
    private func setImage(){
        self.setURL(self.person.image, for: self.imagePlayer)
        
    }
    
    /// Asigna un url de imagen a una UIImage View.
    ///
    /// - Parameter URL: URL a Agregar, Viw a la cual agregar la imagen.
    private func setURL(_ url: URL, for view: UIImageView){
        
        view.startAnimating()
        
        view.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "venados"), options: [.preloadAllFrames], progress: .none) { (image, error, cahce, url) in
            
            if(error != nil){
                print("-----------ERROR-----------")
                print(error!)
                print("-----------ERROR-----------")
            }
            
            view.stopAnimating()
            view.clipsToBounds = true
        }
        
    }

}

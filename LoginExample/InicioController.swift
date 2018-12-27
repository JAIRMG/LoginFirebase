//
//  InicioController.swift
//  LoginExample
//
//  Created by Jair Moreno Gaspar on 12/26/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class InicioController: UIViewController {
    
    let botonRegresar: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        botonRegresar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        botonRegresar.center = self.view.center
        botonRegresar.backgroundColor = UIColor(white: 0, alpha: 0.5)
        botonRegresar.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.view.addSubview(botonRegresar)
        
    }
    
    @objc func logout(){
        print("logout")
        self.dismiss(animated: true, completion: nil)
    }
    
}

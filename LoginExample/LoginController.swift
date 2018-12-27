//
//  LoginController.swift
//  LoginExample
//
//  Created by Jair Moreno Gaspar on 12/26/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let name: UITextField = UITextField()
    let pass: UITextField = UITextField()
    let registerButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        name.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.2, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        name.placeholder = "Correo electrónico"
        name.setBottomBorder(color: UIColor.gray)
        
        pass.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.3, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        pass.placeholder = "Contraseña"
        pass.setBottomBorder(color: UIColor.gray)
        
        registerButton.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.5, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        registerButton.layer.cornerRadius = 10
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = UIColor.black
        registerButton.setTitle("Ingresar", for: .normal)
        registerButton.addTarget(self, action: #selector(checkLogin), for: .touchUpInside)
        
        
        self.view.addSubview(name)
        self.view.addSubview(pass)
        self.view.addSubview(registerButton)
        
    }
    
    @objc func checkLogin(){
        
        guard (name.text?.count)! > 5 && ((name.text?.contains("@"))!) else {
            print("name incorrecto")
            return
        }
        
        guard (pass.text?.count)! > 5  else {
            print("pass incorrecta")
            return
        }
        
        showActivityIndicatory(uiView: self.view)
        
        Auth.auth().signIn(withEmail: name.text!.replacingOccurrences(of: " ", with: ""), password: pass.text!.replacingOccurrences(of: " ", with: "")) { (result, error) in
            if error == nil {
                print("logueado exitoso")
                hideActivityIndicatory()
                self.goToInicio()
                
                
            } else {
                print("error al loguearse")
                hideActivityIndicatory()
                let alertController = UIAlertController(title: "Inicio de sesión inválido", message: errorFirebase(error: error!.localizedDescription), preferredStyle: .alert)
                let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed default");
                }
                alertController.addAction(action1)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
        }
        
    }
    
    @objc func goToInicio(){
        let inicioController = InicioController()
        self.present(inicioController, animated: true, completion: nil)
        
    }
    
}



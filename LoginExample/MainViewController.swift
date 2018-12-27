//
//  ViewController.swift
//  LoginExample
//
//  Created by Jair Moreno Gaspar on 12/20/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let botonRegistro: UIButton = UIButton()
    let botonInicio: UIButton = UIButton()
    
    var alto: CGFloat = CGFloat()
    var ancho: CGFloat = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
        
        setUpViews()
        
    }
    
    func setUpViews(){
        
        alto = self.view.frame.height
        ancho = self.view.frame.width
        
        botonInicio.frame = CGRect(x: ancho * 0.25, y: alto * 0.6, width: ancho * 0.5, height: alto * 0.07)
        botonInicio.layer.cornerRadius = 10
        botonInicio.backgroundColor = UIColor.white
        botonInicio.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
        
        botonRegistro.frame = CGRect(x: ancho * 0.25, y: alto * 0.7, width: ancho * 0.5, height: alto * 0.07)
        botonRegistro.layer.cornerRadius = 10
        botonRegistro.backgroundColor = UIColor.white
        botonRegistro.addTarget(self, action: #selector(goToRegistro), for: .touchUpInside)
        
        self.view.addSubview(botonInicio)
        self.view.addSubview(botonRegistro)
        
        
    }

    
    @objc func goToRegistro(){
        print("registro")
        let registroController = RegistroController()
        self.navigationController?.pushViewController(registroController, animated: true)
    }
    
    @objc func goToLogin(){
        print("login")
        let loginController = LoginController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    
    
    
    //MARK: LANDSCAPE
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        switch UIDevice.current.orientation {
        case .portrait:
            print("portrait")
            //buttonPrueba.frame = CGRect(x: ancho * 0.1, y: alto * 0.1, width: ancho * 0.8, height: alto * 0.15)
            botonInicio.frame = CGRect(x: ancho * 0.25, y: alto * 0.6, width: ancho * 0.5, height: alto * 0.07)
            botonRegistro.frame = CGRect(x: ancho * 0.25, y: alto * 0.7, width: ancho * 0.5, height: alto * 0.07)
        case .portraitUpsideDown:
            print("portraitDown")
            //buttonPrueba.frame = CGRect(x: ancho * 0.1, y: alto * 0.1, width: ancho * 0.8, height: alto * 0.15)
            botonInicio.frame = CGRect(x: ancho * 0.25, y: alto * 0.6, width: ancho * 0.5, height: alto * 0.07)
            botonRegistro.frame = CGRect(x: ancho * 0.25, y: alto * 0.7, width: ancho * 0.5, height: alto * 0.07)
        case .landscapeLeft:
            print("landscapeLeft")
            //buttonPrueba.frame = CGRect(x: alto * 0.1, y: ancho * 0.1, width: alto * 0.8, height: ancho * 0.15)
            botonInicio.frame = CGRect(x: alto * 0.25, y: ancho * 0.6, width: alto * 0.5, height: ancho * 0.07)
            botonRegistro.frame = CGRect(x: alto * 0.25, y: ancho * 0.7, width: alto * 0.5, height: ancho * 0.07)
        case .landscapeRight:
            print("landscapeRight")
            //buttonPrueba.frame = CGRect(x: alto * 0.1, y: ancho * 0.1, width: alto * 0.8, height: ancho * 0.15)
            botonInicio.frame = CGRect(x: alto * 0.25, y: ancho * 0.6, width: alto * 0.5, height: ancho * 0.07)
            botonRegistro.frame = CGRect(x: alto * 0.25, y: ancho * 0.7, width: alto * 0.5, height: ancho * 0.07)
        default:
            break
        }
        
        //
        //        if UIDevice.current.orientation.isLandscape{
        //            print("landscape")
        //            buttonPrueba.frame = CGRect(x: ancho * 0.3, y: alto * 0.4, width: ancho * 0.4, height: alto * 0.2)
        //            buttonPrueba.backgroundColor = UIColor.black
        //        } else if UIDevice.current.orientation.isPortrait{
        //
        //        }
        
        
        
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.all;
        }
    }
    

}


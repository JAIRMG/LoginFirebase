//
//  FuncionesGenerales.swift
//  LoginExample
//
//  Created by Jair Moreno Gaspar on 12/26/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

func showActivityIndicatory(uiView: UIView) {
    let container: UIView = UIView()
    container.tag = 10
    container.frame = uiView.frame
    container.center = uiView.center
    container.backgroundColor = UIColor(white: 0, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = uiView.center
    loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
    actInd.style =
        UIActivityIndicatorView.Style.whiteLarge
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    actInd.startAnimating()
}


func hideActivityIndicatory(){
    let controladorActual = UIApplication.topViewController()
    DispatchQueue.main.async {
        
        let subvistas = controladorActual?.view!.subviews
        
        for subvista in subvistas! where subvista.tag == 10 {
            
            subvista.removeFromSuperview()
            
        }
        
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


func errorFirebase(error: String) -> String {
    if error.contains("no user"){
        return "Email incorrecto"
    } else if error.contains("password is invalid"){
        return "Contraseña incorrecta"
    } else {
        return "Error desconocido"
    }
}

//
//  Util.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit

class Util: NSObject {
    
    static let shared = Util()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private func setSpinner() {
       
        let window = SceneDelegate.shared?.window
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        activityIndicator.color = UIColor(hexString: "#ffffff")
        activityIndicator.tintColor = UIColor(hexString: "#ffffff")
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y :loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        loadingView.center = window!.center
        self.setGradientBackground(view: loadingView)
        window?.addSubview(loadingView)
        
        window?.isUserInteractionEnabled = false

        activityIndicator.startAnimating()
    }
    public func showSpinner() {
        DispatchQueue.main.async {
            self.setSpinner()
        }
    }
    public func hideSpinner() {
        DispatchQueue.main.async {
            self.removeSpinner()
        }
    }
    private func removeSpinner() {
        let window = SceneDelegate.shared?.window
        
        activityIndicator.stopAnimating()
        window?.isUserInteractionEnabled = true
        //        uiView.isUserInteractionEnabled = true
        loadingView.removeFromSuperview()
    }
    private func setGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer()
        for layer in view.layer.sublayers ?? [] {
            if layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        }
        gradientLayer.colors = [UIColor(hexString: "#F5A1A1").cgColor, UIColor(hexString: "#F5A1A1").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.layoutIfNeeded()
        
        gradientLayer.name = "gradient"
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.layoutIfNeeded()
    }
}

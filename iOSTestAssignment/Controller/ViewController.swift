//
//  ViewController.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit
import AAExtensions

class ViewController: UIViewController {

    @IBOutlet weak var loginTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func submitTap(_ sender: Any) {
        if loginTxt.text?.count == 0 {
            self.aa_showAlert("Warning", text: "Login text is mandatory!")
            return
        }
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let vc = mainView.instantiateViewController(withIdentifier: "SearchApiListVC") as! SearchApiListVC
        vc.login = loginTxt.text!
        self.show(vc, sender: self)
    }
}


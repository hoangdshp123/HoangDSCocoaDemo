//
//  LoginSSOVC.swift
//  HoangDSCocoaDemo
//
//  Created by VTP Digitalize on 1/2/20.
//  Copyright © 2020 VTP Digitalize. All rights reserved.
//

import UIKit
import KRProgressHUD

protocol loginDelegate {
    func tokenReturn (_ token: String)
}

class LoginSSOVC: UIViewController {

    @IBOutlet var tf1: UITextField!
    @IBOutlet var tf2: UITextField!
    var onComplete: ((_ result: String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginClicked(_ sender: Any) {
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            KRProgressHUD.dismiss()
            self.dismiss(animated: true) {}
            self.onComplete?( "eyJhbGciOiJFUzI1NiJ9.eyJzdWIiOiIwMzI3NDk3OTk2IiwiU1NPSWQiOiIzNTE3MGIyMi1iZGE5LTRlOGMtYjk0OC0xYzc5MjJhOGJhMDMiLCJVc2VySWQiOjcyMDA3OTcsIkZyb21Tb3VyY2UiOjIsIlRva2VuIjoiMTEzNkJDODVBNTM0OUVCMzcxMDFEOTczOTRBRENBNzciLCJleHAiOjE2MDg4OTAxMzAsIlBhcnRuZXIiOjB9.H36r4_GGiCJbtD4BhEH3sBYEuXe7F-Z8OBvqt3AaFO87QJQ9fhG6J2mOZyV0sojgKHVQeId_VxiAKArARmaTkw")
        }
        
    }
    
}

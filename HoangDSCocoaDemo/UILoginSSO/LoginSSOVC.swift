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
    var onComplete: ((_ userName: String, _ password: String, _ token: String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginClicked(_ sender: Any) {
        if (self.tf1.text ?? "").isEmpty {
            let alert = UIAlertController(title: "Thông báo", message: "User name không được để trống", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if (self.tf2.text ?? "").isEmpty {
            let alert = UIAlertController(title: "Thông báo", message: "Password không được để trống", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            KRProgressHUD.dismiss()
            let userName = self.tf1.text ?? ""
            let password = self.tf2.text ?? ""
            if userName != "hoanghp1234" || password != "hoanghp1234" {
                let alert = UIAlertController(title: "Thông báo", message: "Tài khoản hoặc mật khẩu không chính xác", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.dismiss(animated: true) {}
            self.onComplete?(userName, password,  "eyJhbGciOiJFUzI1NiJ9.eyJzdWIiOiIwMzI3NDk3OTk2IiwiU1NPSWQiOiIzNTE3MGIyMi1iZGE5LTRlOGMtYjk0OC0xYzc5MjJhOGJhMDMiLCJVc2VySWQiOjcyMDA3OTcsIkZyb21Tb3VyY2UiOjIsIlRva2VuIjoiMTEzNkJDODVBNTM0OUVCMzcxMDFEOTczOTRBRENBNzciLCJleHAiOjE2MDg4OTAxMzAsIlBhcnRuZXIiOjB9.H36r4_GGiCJbtD4BhEH3sBYEuXe7F-Z8OBvqt3AaFO87QJQ9fhG6J2mOZyV0sojgKHVQeId_VxiAKArARmaTkw")
        }
        
    }
    
}

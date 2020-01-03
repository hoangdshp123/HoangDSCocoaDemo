//
//  HoangDSCocoaDemo.swift
//  HoangDSCocoaDemo
//
//  Created by VTP Digitalize on 12/31/19.
//  Copyright © 2019 VTP Digitalize. All rights reserved.
//
import Foundation
import UIKit

public class HoangDSCocoaDemo {
    public static func UIIDNum() -> String {
        return "DemoLib ------> abcde"
    }
    
    public static func openLoginSSO(viewController: UIViewController, callback: @escaping (_ token: String?) -> Void) {
        let frameworkBundle = Bundle(identifier:"org.cocoapods.HoangDSCocoaDemo")
        let loginSSOVC = LoginSSOVC(nibName: "LoginSSOVC", bundle: frameworkBundle)
        loginSSOVC.onComplete = { result in
            callback(result)
            viewController.navigationController?.popViewController(animated: true)
        }
        viewController.present(loginSSOVC, animated: true, completion: {})
    }
    
    public static func logoutSSO(viewController: UIViewController) {

    }
}

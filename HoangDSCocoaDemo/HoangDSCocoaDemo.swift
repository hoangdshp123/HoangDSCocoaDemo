//
//  HoangDSCocoaDemo.swift
//  HoangDSCocoaDemo
//
//  Created by VTP Digitalize on 12/31/19.
//  Copyright © 2019 VTP Digitalize. All rights reserved.
//
import Foundation
import AppAuth
import SwiftyJSON
import KRProgressHUD

public class HoangDSCocoaDemo {
    public static func UIIDNum() -> String {
        return "DemoLib ------> abcde"
    }
    
    public static func openLoginSSO() {
        SSOLogin.openLoginSSO()
    }
    
    public static func logoutSSO(viewController: UIViewController) {
        SSOLogin.requestLogout(presenting: viewController, completion: { (response, error) in
            print("Log out failed")
        })
    }
}

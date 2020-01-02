//
//  LoginFacebookGoogleAPIs.swift
//  MyViettelPost
//
//  Created by Hoàng Minh Thành on 7/4/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Foundation
import Alamofire

class LoginFBGGAPIs {
    
    class func loginFBGG(type: Int, source: Int, token: String, success callbackSuccess: @escaping (InfoAccount) -> Void, failed callbackFailure: @escaping (_ message: String, _ status: Int?) -> Void) {
        let parameters: Parameters = ["TYPE": type, "SOURCE": source, "ACCESS_TOKEN": token]
        BaseRequest.sharedInstance.postAPI(K.Path.loginFBGG, param: parameters) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                if let json = jsonResponse {
                    if let status = json["status"].int, status == 301 {
                        if let message = json["message"].string {
                            callbackFailure(message, status)
                            return
                        }
                    }
                    User.shared.loginType = (type == 11) ? LoginType.fb.key : LoginType.gg.key
                    User.shared.updateAccountFromFBGG(json: json)
                    UserDefaults.standard.set(User.shared.phone, forKey: "phoneString")
                    callbackSuccess(InfoAccount.init(dict: jsonResponse!["accountInfo"]))
                } else {
                    callbackFailure(error ?? "", nil)
                }
            } else {
                if let json = jsonResponse {
                    if let status = json["status"].int {
                        callbackFailure(error!, status)
                        return
                    }
                }
                callbackFailure(error!, nil)
            }
        }
    }
}

//
//  LogoAPIs.swift
//  MyViettelPost
//
//  Created by Mac on 2/11/19.
//  Copyright © 2019 ViettelPost. All rights reserved.
//

import Foundation
import Alamofire

class  LogoAPIs {
    class func updateLogo(userID: Int, logo: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["AVATAR_STRING": logo, "CUS_ID": userID]
        BaseRequest.sharedInstance.postAPI(K.Path.uploadLogo, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    class func getLogo(userID: Int, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String, _ data: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["companyId": userID]
        BaseRequest.sharedInstance.getAPI(K.Path.getLogo, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let data = json["data"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message, data)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    class func deleteLogo(userID: Int, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["CUS_ID": userID]
        BaseRequest.sharedInstance.postAPI(K.Path.deleteLogo, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
}


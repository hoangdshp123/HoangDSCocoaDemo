//
//  InviteInstallAppAPIs.swift
//  MyViettelPost
//
//  Created by Hoàng Minh Thành on 7/19/18.
//  Copyright © 2018 ViettelPost. All rights reserved.
//

import Foundation
import Alamofire

class InviteInstallAppAPIs {
    
    class func getUserInfo(phones: String, success callbackSuccess: @escaping (_ data: [String], _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["PHONE": phones]
        BaseRequest.sharedInstance.postAPI(K.Path.getInvitePhone, param: params) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                if let json = jsonResponse {
                    let error = json["error"].boolValue
                    let message = json["message"].stringValue
                    let data = json["data"].arrayValue.map { $0.stringValue }
                    callbackSuccess(data, error, message)
                } else {
                    callbackFailure(error ?? "")
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    class func getCountAllInvite(inviteCode: String, success callbackSuccess: @escaping (_ count: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI(K.Path.getCountAllInvite + "/" + inviteCode, param: nil) { (response, isSuccess, message) in
            if let json = response {
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    let count = json["data"]["total"].intValue
                    callbackSuccess(count, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(message ?? "")
            }
        }
    }
    
    class func getCountMonthInvite(inviteCode: String, success callbackSuccess: @escaping (_ count: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI(K.Path.getCountMonthInvite + "/" + inviteCode, param: nil) { (response, isSuccess, message) in
            if let json = response {
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    let count = json["data"]["total"].intValue
                    callbackSuccess(count, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(message ?? "")
            }
        }
    }
}

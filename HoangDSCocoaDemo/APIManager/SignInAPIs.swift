//
//  SignInAPIs.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 4/21/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//
import Alamofire
import Foundation
import SwiftyJSON

class SignInAPIs {

    // MARK: - Lấy OTP
    
    class func getOTP(PHONE: String, captcha: String? = nil, success callbackSuccess: @escaping (_ message: String) -> Void, failed callbackFailure: @escaping (String?) -> Void) {
        var parameter: Parameters = [kPHONE: PHONE]
        
        if let cap = captcha {
            parameter["CAPTCHA"] = cap
        }
        
        BaseRequest.sharedInstance.postAPI(urlSendSMSLogin, param: parameter, replaceUrl: "https://api2.viettelpost.vn/api/user/sendSMSLogin") { jsonResponse, isSuccess, _ in
            guard let response = jsonResponse else {
                callbackFailure("error")
                return
            }
            let isError = response["error"].boolValue
            if isSuccess && !isError {
                let message = response["message"].stringValue
                callbackSuccess(message)
            } else {
                let message = response["message"].stringValue
                callbackFailure(message)
            }
        }
    }
    
    class func loginSMS(PHONE: String, OTP: String, success callbackSuccess: @escaping (_ result: JSON, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kPHONE: PHONE, kOTP: OTP, "SOURCE": "2"]
        UserDefaults.standard.set(PHONE, forKey: "phoneString")
        
        BaseRequest.sharedInstance.postAPI(urlLoginSMS, param: parameter) { jsonResponse, isSuccess, error in
            guard let response = jsonResponse else {
                callbackFailure("Text.messenger_error_system_error")
                return
            }
            if isSuccess {
                let error = response["error"].boolValue
                let message = response["message"].stringValue
                if error {
                    callbackFailure(response["message"].stringValue)
                } else {
                    User.shared.initData(dict: response)
                    UserDefaults.standard.set(response["Partner"].intValue, forKey: "Partner")
                    UserDefaults.standard.set(response["UserName"].stringValue, forKey: "UserName")
                    UserDefaults.standard.set(response["UserId"].intValue, forKey: "UserId")
                    UserDefaults.standard.set(response["Role"].intValue, forKey: "Role")
                    UserDefaults.standard.set(response["FromSource"].stringValue, forKey: "FromSource")
                    UserDefaults.standard.set(response["TokenKey"].stringValue, forKey: "TokenKey")
                    callbackSuccess(response, error, message) 
                }
            } else {
                callbackFailure(error ?? "Text.messenger_error_system_error")
            }
        }
    }
    
    class func saveUserPublic(phone: String,email  : String, firstName: String, lastName: String, address: String, provinceId: String, districtId: String, wardId: String, provinceName: String, districtName: String, wardName: String, latitude: Float, longitude: Float, cusId: Int, receiveDate: Int64, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        
        let parameter: Parameters = ["phone": phone, "email": email, "firstName": firstName, "lastName": lastName, "address": address, "provinceId": provinceId, "districtId": districtId, "wardId": wardId, "provinceName": provinceName, "districtName": districtName, "wardName": wardName, "latitude": latitude, "longitude": longitude, "cusId": cusId, "receiveDate": receiveDate, "source": 2]
        
        BaseRequest.sharedInstance.postAPI(urlSaveUserPublic, param: parameter) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func getCapcha(success callbackSuccess: @escaping (_ status: Int, _ token: String, _ url: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {

        BaseRequest.sharedInstance.getAPI("", replaceUrl: K.baseUrlCapcha + "captcha", replaceHeader: nil, param: nil) { (response, isSuccess, error) in
            if isSuccess {
                let status = response!["status"].intValue
                callbackSuccess(status, response!["data"]["token"].stringValue, response!["data"]["url"].stringValue)
            } else {
               callbackFailure(error!)
            }
        }
    }
    
    class func loginWithCapcha(token: String, code: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = ["code": code]
        BaseRequest.sharedInstance.postAPI("", param: parameter, replaceUrl: K.baseUrlCapcha + "login", header: ["X-Auth-Token": token]) { (response, isSuccess, error) in
            if isSuccess {
                let status = response!["status"].intValue
                let error = response!["error"].boolValue
                let message = response!["message"].stringValue
                User.shared.loginType = LoginType.email.key
                User.shared.initData(dict: response!["data"])
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func updatePhoneNumber(phone: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        print(phone)
        let parameter: Parameters = ["PHONE": phone]
        BaseRequest.sharedInstance.postAPI(urlUpdatePhoneNumber, param: parameter) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
}

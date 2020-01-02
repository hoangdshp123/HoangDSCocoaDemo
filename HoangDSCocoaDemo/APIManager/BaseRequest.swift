//
//  BaseRequests.swift
//  MyViettelPost
//
//  Created by Pham Diep on 3/20/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Alamofire
import Firebase
import Foundation
import SiFUtilities
import Sentry
import SwiftyJSON
import KRProgressHUD

typealias APIRequestFailureHandler = (_ message: String) -> Void

class BaseRequest {
    static let sharedInstance = BaseRequest()
    let sessionManager: Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["api.viettelpost.vn": .disableEvaluation]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(configuration: URLSessionConfiguration.default,
                                           serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        return man
    }()
    
    private init() {
    }
    
    func postAPI(_ path: String,
                 param: Parameters?,
                 replaceUrl: String? = "",
                 header: HTTPHeaders? = nil,
                 callback: @escaping (_ jsonRespose: JSON?, _ callSuccess: Bool, _ messErr: String?) -> Void) {
        let header: HTTPHeaders = (header == nil) ? ["Token": User.shared.tokenKey, "User-Agent": Util.getUserAgent()] : header!
        print("\(User.shared.tokenKey)")
        let urlPath = replaceUrl == "" ? K.baseURL + path : replaceUrl!
        
        sessionManager.request(urlPath,
                               method: .post,
                               parameters: param,
                               encoding: JSONEncoding.default,
                               headers: header).responseJSON { response in
            let statusCode = response.response?.statusCode ?? 0
            switch statusCode {
            case 200, 201:
                switch response.result {
                case .success(let value):
                    if let jsonObj = JSON.init(rawValue: value) {
                        
                        if jsonObj["error"].boolValue {
                            let msg = jsonObj["message"].stringValue
                            if jsonObj["status"].intValue == 201, msg.contains("User của bạn đã đăng nhập trên máy khác") {
                                KRProgressHUD.dismiss()
//                                if !(UIApplication.topViewController()?.isKind(of: UIAlertController.self) ?? true) {
//                                    UIApplication.topViewController()?.forceLogout(message: "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!")
//                                }
                                return
                            }
                            callback(jsonObj, false, jsonObj["message"].stringValue)
                            return
                        }
                        callback(jsonObj, true, jsonObj["message"].stringValue)
                        
                    } else {
                        ProviderConfiguration.shared.logger.logDataResponse(response)
                        let data = JSON(parseJSON: "")
                        callback(data, false, String(format: "%d", statusCode))
                    }
                case .failure(let error):
                    ProviderConfiguration.shared.logger.logDataResponse(response)
                    let data = JSON(parseJSON: "")
                    callback(data, false, error.localizedDescription)
                }
//                if let result = response.result.value {
//                    let jsonObj = JSON(response.data ?? result)
//                    if jsonObj["error"].boolValue {
//                        callback(jsonObj, false, jsonObj["message"].stringValue)
//                        return
//                    }
//                    callback(jsonObj, true, nil)
//                } else {
//                    ProviderConfiguration.shared.logger.logDataResponse(response)
//                    let data = JSON(parseJSON: "")
//                    callback(data, false, String(format: "%d", statusCode))
//                }
            default:
                
                if let _replaceUrl = replaceUrl, _replaceUrl.contains("login3g") {
                    if let result = response.result.value {
                        let data = JSON(response.data ?? result)
                        callback(data, false, data["message"].stringValue)
                        return
                    }
                }
                
                ProviderConfiguration.shared.logger.logDataResponse(response)
                
                let data = JSON(parseJSON: "")
                callback(data, false, "Có lỗi xảy ra khi kết nối tới server")
            }
        }
    }
    
    func postAPINotCheckToken(_ path: String,
                     param: Parameters?,
                     replaceUrl: String? = "",
                     header: HTTPHeaders? = nil,
                     callback: @escaping (_ jsonRespose: JSON?, _ callSuccess: Bool, _ messErr: String?) -> Void) {
            let header: HTTPHeaders = (header == nil) ? ["Token": User.shared.tokenKey, "User-Agent": Util.getUserAgent()] : header!
            print("\(User.shared.tokenKey)")
            let urlPath = replaceUrl == "" ? K.baseURL + path : replaceUrl!
            
            sessionManager.request(urlPath,
                                   method: .post,
                                   parameters: param,
                                   encoding: JSONEncoding.default,
                                   headers: header).responseJSON { response in
                let statusCode = response.response?.statusCode ?? 0
                switch statusCode {
                case 200, 201:
                    switch response.result {
                    case .success(let value):
                        if let jsonObj = JSON.init(rawValue: value) {
                            
                            if jsonObj["error"].boolValue {
                                let msg = jsonObj["message"].stringValue
                                callback(jsonObj, false, jsonObj["message"].stringValue)
                                return
                            }
                            callback(jsonObj, true, jsonObj["message"].stringValue)
                            
                        } else {
                            ProviderConfiguration.shared.logger.logDataResponse(response)
                            let data = JSON(parseJSON: "")
                            callback(data, false, String(format: "%d", statusCode))
                        }
                    case .failure(let error):
                        ProviderConfiguration.shared.logger.logDataResponse(response)
                        let data = JSON(parseJSON: "")
                        callback(data, false, error.localizedDescription)
                    }
    //                if let result = response.result.value {
    //                    let jsonObj = JSON(response.data ?? result)
    //                    if jsonObj["error"].boolValue {
    //                        callback(jsonObj, false, jsonObj["message"].stringValue)
    //                        return
    //                    }
    //                    callback(jsonObj, true, nil)
    //                } else {
    //                    ProviderConfiguration.shared.logger.logDataResponse(response)
    //                    let data = JSON(parseJSON: "")
    //                    callback(data, false, String(format: "%d", statusCode))
    //                }
                default:
                    
                    if let _replaceUrl = replaceUrl, _replaceUrl.contains("login3g") {
                        if let result = response.result.value {
                            let data = JSON(response.data ?? result)
                            callback(data, false, data["message"].stringValue)
                            return
                        }
                    }
                    
                    ProviderConfiguration.shared.logger.logDataResponse(response)
                    
                    let data = JSON(parseJSON: "")
                    callback(data, false, "Có lỗi xảy ra khi kết nối tới server")
                }
            }
        }
    
    
    func getAPI(_ path: String,
                replaceUrl: String? = "",
                replaceHeader: HTTPHeaders? = [:],
                param: Parameters?,
                callback: @escaping (_ jsonRespose: JSON?, _ callSuccess: Bool, _ messErr: String?) -> Void) {
        var header: HTTPHeaders?
        if replaceHeader == nil {
            header = nil
        } else if replaceHeader! == [:] {
            header = ["Token": User.shared.tokenKey, "User-Agent": Util.getUserAgent()]
        } else {
            header = replaceHeader!
        }
        
        let urlPath = replaceUrl == "" ? K.baseURL + path : replaceUrl!
        
        sessionManager.request(urlPath,
                               method: .get,
                               parameters: param,
                               headers: header).responseJSON { response in
            let statusCode = response.response?.statusCode ?? 0
            switch statusCode {
            case 200, 201:
                if let result = response.result.value {
                    let jsonObj = JSON(response.data ?? result)
                    
                    if jsonObj["error"].boolValue {
                        let msg = jsonObj["message"].stringValue
                        if jsonObj["status"].intValue == 201, msg.contains("User của bạn đã đăng nhập trên máy khác") {
                            if !(UIApplication.topViewController()?.isKind(of: UIAlertController.self) ?? true) {
//                                UIApplication.topViewController()?.forceLogout(message: "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!")
                            }
                        }
                    }
                    callback(jsonObj, true, jsonObj["message"].stringValue)
                } else {
                   ProviderConfiguration.shared.logger.logDataResponse(response)
                    let data = JSON(parseJSON: "")
                    callback(data, false, String(format: "%d", statusCode))
                }
            default:
                var data: JSON = JSON(parseJSON: "")
                if let resData = response.data {
                    data = JSON(resData)
                }
                ProviderConfiguration.shared.logger.logDataResponse(response)
                callback(data, false, "Có lỗi xảy ra khi kết nối tới server")
            }
        }
    }
    
    func insertDevice(idToken: String,
                      handlerResult: @escaping (_ msgReturn: String) -> Void) {
        let param: Parameters = ["USER_ID": User.shared.userId,
                                 "IOS_Token": idToken,
                                 "Android_Token": "",
                                 "pTYPE": 2]
        postAPI(K.Path.insertDevice,
                param: param) { _, isSuccess, _ in
            if isSuccess {
                handlerResult("đã đăng ký device")
            } else {
                handlerResult("đăng ký device thất bại")
            }
        }
    }
    
    func confirmRequestStaff(selectAccept: Bool,
                             wareHouseId: String,
                             handlerResult: @escaping (_ isSuccess: Bool, _ errMsg: String) -> Void) {
        let param: Parameters = ["TYPE": selectAccept ? "1" : "2",
                                 "GROUPADDRESS_ID": wareHouseId]
        postAPI(K.Path.staffConfirm, param: param) { jsonResponse, isSuccess, errMsg in
            if isSuccess {
                if jsonResponse!["error"].boolValue {
                    handlerResult(false, jsonResponse!["message"].stringValue)
                } else {
                    handlerResult(true, jsonResponse!["message"].stringValue)
                }
            } else {
                handlerResult(false, errMsg!)
            }
        }
    }
    
    func getTransporterInfo(transporterType: String,
                            orderNumber: String,
                            callbackSuccess: @escaping (_ result: Transporter) -> Void,
                            callbackFailure: @escaping (_ errMsg: String) -> Void) {
        let param: Parameters = ["order_number": orderNumber,
                                 "TYPE": transporterType]
        getAPI(K.Path.transporterInfo, param: param) { jsonResponse, isSuccess, errMsg in
            if isSuccess {
                if jsonResponse!["error"].boolValue {
                    callbackFailure(jsonResponse!["message"].stringValue)
                } else {
                    let transporter = Transporter(dict: jsonResponse!["data"])
                    callbackSuccess(transporter)
                }
            } else {
                callbackFailure(errMsg!)
            }
        }
    }
    
//    func callAnalyticAPI(params: Parameters, nameEvent: String) {
//        postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { (_, _, _) in
//
//        }
//    }
    
//    let eventFirstOpen = "open"
//    let utmAppInvite = "app_invite"
    
    func sendAnalytic(nameEvent: String) {
        var utm_campaign = ""
        var utm_source = ""
        var utm_medium = ""
        
        if let deepLinkStr = UserDefaults.standard.value(forKey: kURLDeepLink) as? String {
            guard let deepLinkUrl = URL(string: deepLinkStr) else { return }
            utm_campaign = deepLinkUrl.valueOf("utm_campaign") ?? ""
            utm_source = deepLinkUrl.valueOf("utm_source") ?? ""
            utm_medium = deepLinkUrl.valueOf("utm_medium") ?? ""
        }
        
        var dataRegister = ""
        if let userPhone = UserDefaults.standard.value(forKey: kPhoneUser) as? String {
            dataRegister = userPhone
        } else if let userEmail = UserDefaults.standard.value(forKey: kEmailUser) as? String {
            dataRegister = userEmail
        }
        
        let param: Parameters = ["EVENT": nameEvent,
                                 "UTM_CAMPAIGN": utm_campaign,
                                 "UTM_SOURCE": utm_source,
                                 "UTM_MEDIUM": utm_medium,
                                 "DEVICE_TYPE": 0, // ios
                                 "DEVICE_ID": UIDevice.current.identifierForVendor!.uuidString,
                                 "REGISTER_PHONE": dataRegister]
        
//        postAPI("", param: param, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { (_, _, _) in
//
//        }
        callAnalyticAPI(params: param, nameEvent: nameEvent, dataUser: dataRegister)
    }
    
    func callAnalyticAPI(params: [String: Any], nameEvent: String, dataUser: String) {
        if nameEvent == "login" && dataUser != "" {
            postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                if isSuccess == false {
                    self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                        if isSuccess == false {
                            self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                                if isSuccess == false {
                                    self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, _, _ in
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if nameEvent == "open" {
            postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                if isSuccess == false {
                    self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                        if isSuccess == false {
                            self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, isSuccess, _ in
                                if isSuccess == false {
                                    self.postAPI("", param: params, replaceUrl: "https://url.viettelpost.vn/affiliate/update") { _, _, _ in
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sendFirebaseAnalytic(isRegister: Bool) {
        if let deepLinkStr = UserDefaults.standard.value(forKey: kURLDeepLinkFirebase) as? String {
            guard let deepLinkUrl = URL(string: deepLinkStr) else { return }
            
            let utm_campaign = deepLinkUrl.valueOf("utm_campaign") ?? ""
            let utm_source = deepLinkUrl.valueOf("utm_source") ?? ""
            let utm_medium = deepLinkUrl.valueOf("utm_medium") ?? ""
            
            // {\"device_id\":\"867934024669998\",\"phone_number\":\"0977212594\",\"email\":\"facebook26894@gmail.com\"}
            
            var checkPhone = false
            if User.shared.phone != "" {
                checkPhone = true
            }
            
            if checkPhone {
                let dictContent = ["c": utm_campaign,
                                   "s": utm_source,
                                   "m": utm_medium,
                                   "u": User.shared.phone,
                                   "new": isRegister ? "1" : "0"]
                
                if let theJSONData = try? JSONSerialization.data(withJSONObject: dictContent, options: []) {
                    if let theJSONText = String(data: theJSONData, encoding: .utf8) {
                        Analytics.logEvent(AnalyticsEventLogin, parameters: [AnalyticsParameterCampaign: utm_campaign,
                                                                             AnalyticsParameterMedium: utm_medium,
                                                                             AnalyticsParameterSource: utm_source,
                                                                             AnalyticsParameterContent: theJSONText])
                        UserDefaults.standard.removeObject(forKey: kURLDeepLinkFirebase)
                    }
                }
            }
        }
    }
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}

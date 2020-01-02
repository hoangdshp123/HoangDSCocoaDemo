//
//  SSO.swift
//  MyViettelPost
//
//  Created by Hoang Minh Thanh on 5/18/19.
//  Copyright © 2019 ViettelPost. All rights reserved.
//

import Foundation
import AppAuth
import SwiftyJSON
import KRProgressHUD

class SSOLogin {
    
    static let baseURL = "https://id.viettelpost.vn" //https://oid-cpn.oc.viettelpost.vn
    static let clientId = "vtpapp.new"
    static let clientSecret = "vtp-web-new"
    
    class func requestAuthorization(presenting: UIViewController, completion: @escaping (_ authState: OIDTokenResponse?, _ error: Error?) -> Void) {
        let issuer = URL.init(string: baseURL)!
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { (configuration, error) in
            if let config = configuration, error == nil {
                let redirectURL = URL.init(string: "viettelpost://oauthredirect")!
                let clientId = SSOLogin.clientId
                let scopes = [OIDScopeProfile, OIDScopeOpenID, "se-public-api"]
                let clientSecret = SSOLogin.clientSecret
                let request = OIDAuthorizationRequest.init(configuration: config, clientId: clientId, clientSecret: clientSecret, scopes: scopes, redirectURL: redirectURL, responseType: OIDResponseTypeCode, additionalParameters: ["prompt": "login"])
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: presenting, callback: { (authState, error) in
//                    if let _authState = authState, error == nil {
//                        completion(_authState.lastTokenResponse, nil)
//                    } else {
//                        completion(nil, error)
//                        print(error?.localizedDescription ?? "")
//                    }
//                })
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    class func requestLogin(presenting: UIViewController, completion: @escaping (_ authState: OIDAuthState?, _ state: String?, _ error: Error?) -> Void) {
        let issuer = URL.init(string: baseURL)!
        let config = OIDServiceConfiguration.init(authorizationEndpoint: URL.init(string: "\(baseURL)/connect/authorize")!,
                                                  tokenEndpoint: URL.init(string: "\(baseURL)/connect/token")!,
                                                  issuer: issuer)
        let redirectURL = URL.init(string: "viettelpost://oauthredirect")!
        let clientId = SSOLogin.clientId
        let scopes = [OIDScopeProfile, OIDScopeOpenID, "se-public-api"]
        let clientSecret = SSOLogin.clientSecret
        let request = OIDAuthorizationRequest.init(configuration: config, clientId: clientId, clientSecret: clientSecret, scopes: scopes, redirectURL: redirectURL, responseType: "id_token token", additionalParameters: ["prompt": "login"])
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: presenting, callback: { (authState, error) in
//            if let _authState = authState, error == nil {
//                completion(_authState, _authState.lastAuthorizationResponse.state, nil)
//            } else {
//                completion(nil, nil, error)
//                print(error?.localizedDescription ?? "")
//            }
//        })
    }
    
    class func requestLogout(presenting: UIViewController, completion: @escaping (_ response: OIDEndSessionResponse?, _ error: Error?) -> Void) {
        let redirectURL = URL.init(string: "viettelpost://oauthredirect")!
        let config = OIDServiceConfiguration.init(authorizationEndpoint: URL.init(string: "\(baseURL)/connect/authorize")!,
                                                  tokenEndpoint: URL.init(string: "\(baseURL)/connect/token")!,
                                                  issuer: nil,
                                                  registrationEndpoint: nil,
                                                  endSessionEndpoint: URL.init(string: "\(baseURL)/connect/endsession")!)
        let authStateJson = JSON.init(parseJSON: UserDefaults.standard.string(forKey: "AuthState_\(User.shared.userId)") ?? "")
        let logoutRequest = OIDEndSessionRequest.init(configuration: config, idTokenHint: authStateJson["idToken"].stringValue, postLogoutRedirectURL: redirectURL, additionalParameters: nil)
        let userAgent = OIDExternalUserAgentIOS.init(presenting: presenting)!
        OIDAuthorizationService.present(logoutRequest, externalUserAgent: userAgent) { (response, error) in
            completion(response, error)
        }
    }
    
    class func getAccountInfo(ssoInfo: JSON, tokenSSO: String) {
        ConfigAPIs.getAccountInfoSSO(userId: ssoInfo["UserId"].stringValue, ssoToken: tokenSSO, success: { result in
            KRProgressHUD.dismiss()
            guard let data = result.first else { return }
            User.shared.displayName = "\(data.LASTNAME) \(data.FIRSTNAME)"
            if data.LASTNAME == "" && data.FIRSTNAME == "" {
                User.shared.displayName = data.DISPLAYNAME
            }
            User.shared.districtId = Int(data.DISTRICT_ID)
            User.shared.wardsId = Int(data.WARDS_ID)
            User.shared.phone = data.PHONE
            UserDefaults.standard.set(data.PHONE, forKey: "phoneString")
            if data.DISTRICT_ID <= 0 || data.DISTRICT_ID == nil {
                UserDefaults.standard.set(true, forKey: kLogin)
                UserDefaults.standard.set(LoginType.login(type: LoginType.none), forKey: kLoginType)
                guard let topVC = UIApplication.topViewController() else {
                    return
                }
                topVC.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                BaseRequest.sharedInstance.sendFirebaseAnalytic(isRegister: false)
                UserDefaults.standard.set(true, forKey: kLogin)
                UserDefaults.standard.set(LoginType.login(type: LoginType.none), forKey: kLoginType)
                guard let topVC = UIApplication.topViewController() else {
                    return
                }
                topVC.navigationController?.dismiss(animated: true, completion: nil)
            }
        }, failed: { error in
            KRProgressHUD.dismiss()
            guard let topVC = UIApplication.topViewController() else {
                return
            }
        })
        WalletAPIs.shared.loginWalletNew()
    }
    
    class func openLoginSSO() {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        SSOLogin.requestLogin(presenting: topVC) { (authState, state, error) in
            if let _error = error {
                print(_error)
            } else {
                guard let _token = authState?.lastAuthorizationResponse.accessToken, let _idToken = authState?.lastAuthorizationResponse.idToken else { return }
                KRProgressHUD.show()
                ConfigAPIs.updateSSO(token: _token, idToken: _idToken, success: { (status, error, message, json) in
                    if error {
                        KRProgressHUD.dismiss()
                    } else {
                        if let _authState = authState?.lastAuthorizationResponse {
                            cryptSSOData(authState: _authState, state: state, userId: json["UserId"].stringValue)
                        }
                        getAccountInfo(ssoInfo: json, tokenSSO: _token)
                    }
                }, failed: { error in
                    KRProgressHUD.dismiss()
                })
            }
        }
    }
    
    class func cryptSSOData(authState: OIDAuthorizationResponse, state: String?, userId: String) {
        let ssoJson: [String: String] = ["id_token": authState.idToken ?? "",
                                         "access_token": authState.accessToken ?? "",
                                         "expires_in": authState.accessTokenExpirationDate?.timeIntervalSince1970.stringValue ?? "",
                                         "token_type": authState.tokenType ?? "",
                                         "refresh_token": ""]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(ssoJson) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                BaseRequest.sharedInstance.postAPI("/api/utils/ssoEncrypt", param: ["TokenJson": jsonString]) { (result, isSuccess, error) in
                    if let json = result {
                        var authStateJson = JSON.init(parseJSON: "")
                        authStateJson["accessToken"].stringValue = authState.accessToken ?? ""
                        authStateJson["idToken"].stringValue = authState.idToken ?? ""
                        authStateJson["state"].stringValue = state ?? ""
                        UserDefaults.standard.setValue(authStateJson.rawString(), forKey: "AuthState_\(userId)")
                        UserDefaults.standard.set(authState.accessToken, forKey: "TokenSSO_\(userId)")
                        UserDefaults.standard.set(json["data"].stringValue, forKey: "TokenJson_\(userId)")
                    }
                }
            }
        }
        
    }
    
    class func cryptSSOData(json: JSON, userId: String) {
        let ssoJson: [String: String] = ["id_token": json["idToken"].stringValue,
                                         "access_token": json["accessToken"].stringValue,
                                         "expires_in": json["expiresIn"].intValue.stringValue,
                                         "token_type": json["tokenType"].stringValue,
                                         "refresh_token": json["refreshToken"].stringValue]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(ssoJson) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                BaseRequest.sharedInstance.postAPI("/api/utils/ssoEncrypt", param: ["TokenJson": jsonString]) { (result, isSuccess, error) in
                    if let _json = result {
                        var authStateJson = JSON.init(parseJSON: "")
                        authStateJson["accessToken"].stringValue = json["accessToken"].stringValue
                        if let oldAuthState = UserDefaults.standard.string(forKey: "AuthState_\(userId)") {
                            let oldJson = JSON.init(parseJSON: oldAuthState)
                            authStateJson["idToken"].stringValue = oldJson["idToken"].stringValue
                        }
                        UserDefaults.standard.setValue(authStateJson.rawString(), forKey: "AuthState_\(userId)")
                        UserDefaults.standard.set(json["accessToken"].stringValue, forKey: "TokenSSO_\(userId)")
                        UserDefaults.standard.set(_json["data"].stringValue, forKey: "TokenJson_\(userId)")
                    }
                }
            }
        }
        
    }
    
    class func loginQRCode(_ qrcode: String, success: @escaping () -> Void, failed: @escaping () -> Void) {
        guard let tokenSSO = UserDefaults.standard.string(forKey: "TokenSSO_\(User.shared.userId)") else {
            failed()
            return
        }
        BaseRequest.sharedInstance.postAPI("", param: ["qrCodeId": qrcode,
        "access_token": tokenSSO,
        "languageId": "",
        "languageDefaultId": ""], replaceUrl: "https://idapi.viettelpost.vn/api/QrCode/VerifyQrCode", header: ["Content-Type": "application/json"]) { (response, isSuccess, error) in
            KRProgressHUD.dismiss()
            if let json = response {
                if json["status"].boolValue {
//                    Analytics.logEvent(AnalyticEvent.login_qrcode_thanh_cong.rawValue, parameters: nil)
                    success()
                } else {
//                    Analytics.logEvent(AnalyticEvent.login_qrcode_that_bai.rawValue, parameters: ["message": json["message"].stringValue])
                    failed()
                }
            } else {
//                Analytics.logEvent(AnalyticEvent.login_qrcode_that_bai.rawValue, parameters: ["message": "Lỗi server hoặc timeout"])
                failed()
            }
        }
    }
}

//
//  WalletAPIs.swift
//  MyViettelPost
//
//  Created by Pham Diep on 4/27/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyRSA
import SwiftyJSON

class WalletAPIs {
    enum ObjectType {
        case transData
        case userData
        case userReferenceData
    }
    static let shared = WalletAPIs()
    let sessionManager: Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "w.viettelpost.vn": .disableEvaluation
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    private init() {
    }
    func postAPI(_ path: String,
                 param: Parameters,
                 headerExtent: [ String: String ]? = nil,
                 objectType: ObjectType,
                 callback: @escaping (_ jsonRespose: JSON?, _ callSuccess: Bool, _ messErr: String?) -> Void) {
        
        let secretStr = createSecretString(bodyParam: param, objectType: objectType)
        var header: HTTPHeaders = [ "appKey": LibKey.walletAppKey,
                                    "secretData": secretStr,
                                    "User-Agent": Util.getUserAgent() ]
        if let headerExt = headerExtent {
            for key in headerExt.keys {
                header[key] = headerExt[key]
            }
        }
        sessionManager.request(K.baseWalletUrl + path,
                               method: .post,
                               parameters: param,
                               encoding: JSONEncoding.default,
                               headers: header).responseJSON { (response) in
                                let statusCode = response.response?.statusCode ?? 0
                                switch statusCode {
                                case 200:
                                    if let result = response.result.value {
                                        let jsonObj = JSON.init(response.data ?? result)
                                        callback(jsonObj, true, nil)
                                    } else {
                                        
                                        callback(nil, false, String(format: "%d", statusCode))
                                    }
                                case 404:
                                    callback(nil, false, "Kênh chat không tồn tại")
                                default:
                                    callback(nil, false, "Có lỗi xảy ra khi kết nối tới server")
                                }
        }
    }
    
    func loginWalletNew() {
        BaseRequest.sharedInstance.getAPI("", replaceUrl: "https://s4.viettelpost.vn/v1.0/user/login", replaceHeader: ["Token": User.shared.tokenKey], param: nil) { (response, isSuccess, error) in
            if let json = response {
                let data = json["data"]
                let wallet = WalletInfo.init(json: data)
                WalletInfo.shared.updateNewValue(newData: wallet)
            }
        }
    }
    
    func loginWalletNew(callbackSuccess: @escaping () -> Void,
                        callbackFailed: @escaping (_ errMsg: String) -> Void) {
        BaseRequest.sharedInstance.getAPI("", replaceUrl: "https://s4.viettelpost.vn/v1.0/user/login", replaceHeader: ["Token": User.shared.tokenKey], param: nil) { (response, isSuccess, error) in
            if let json = response {
                let data = json["data"]
                let wallet = WalletInfo.init(json: data)
                WalletInfo.shared.updateNewValue(newData: wallet)
                callbackSuccess()
            } else {
                callbackFailed(error ?? "")
            }
        }
    }
    
    func createSecretString(bodyParam: Parameters, objectType: ObjectType) -> String {
        
        var secretStr = ""
        switch objectType {
        case .userData:
            secretStr = convertToStringUserData(param: bodyParam)
        case .transData:
            secretStr = convertToStringTransData(param: bodyParam)
        case .userReferenceData:
            secretStr = convertToUserReferenceData(param: bodyParam)
        }
       
        return encryptRsaPKCS1AfterMd5(input: secretStr)
    }
    
    func encryptRsaPKCS1AfterMd5(input: String) -> String {
        let url = Bundle.main.url(forResource: "ios", withExtension: "public")!
        do {
            let data = try Data(contentsOf: url)
            let publicKey = try PublicKey.init(data: data)
            let clear = try ClearMessage(string: "input.hexMD5()", using: .utf8)
            let encrypt = try clear.encrypted(with: publicKey, padding: .PKCS1)
            return encrypt.base64String
        } catch {
            return ""
        }
    }
    
    func convertToUserReferenceData(param: Parameters) -> String {
        var resultStr = "[com.viettelpost.wallet.models.core.UserReferenceData"
        resultStr.append("\(param["referenceId"] ?? "null")")
        resultStr.append("\(param["applicationId"] ?? "null")")
        resultStr.append("]")
        return resultStr
    }
    
    func convertToStringUserData(param: Parameters) -> String {
        var resultStr = "[com.viettelpost.wallet.models.core.UserData"
        resultStr.append("\(param["id"] ?? "null")")
        resultStr.append("\(param["username"] ?? "null")")
        resultStr.append("\(param["password"] ?? "null")")
        resultStr.append( "\(param["email"] ?? "null")")
        resultStr.append( "\(param["phone"] ?? "null")")
        resultStr.append( "\(param["firstName"] ?? "null")")
        resultStr.append( "\(param["lastName"] ?? "null")")
        resultStr.append( "\(param["token"] ?? "null")")
        resultStr.append("]")
        return resultStr
    }
    
    func convertToStringTransData(param: Parameters) -> String {
        var resultStr = "[com.viettelpost.wallet.models.TransactionData"
        resultStr.append( "\(param["id"] ?? "null")")
     //   resultStr.append("],[")
        resultStr.append( "\(param["transId"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["fromUserId"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["toUserId"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["amount"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["type"] ?? "null")")
       // resultStr.append("],[")
        resultStr.append( "\(param["content"] ?? "null")")
     //   resultStr.append("],[")
        resultStr.append( "\(param["note"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["status"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["userId"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["transTimestamp"] ?? "null")")
      //  resultStr.append("],[")
        resultStr.append( "\(param["actionTimestamp"] ?? "null")")
        resultStr.append("]")
        return resultStr
    }
}

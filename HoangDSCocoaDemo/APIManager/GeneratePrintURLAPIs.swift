//
//  GeneratePrintURLAPIs.swift
//  MyViettelPost
//
//  Created by Hoàng Minh Thành on 7/19/18.
//  Copyright © 2018 ViettelPost. All rights reserved.
//

import Foundation
import Alamofire

class GeneratePrintURLAPIs {
    class func generateURL(orderNumbers: String, typePaper: Int, success callbackSuccess: @escaping (_ url: String, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["ORDER_NUMBER": orderNumbers, "TYPE": typePaper]
        BaseRequest.sharedInstance.postAPI(K.Path.generatePrintURL, param: params) { (response, isSuccess, error) in
            if let json = response {
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    let enCryptoUrl = json["data"]["enCryptUrl"].stringValue
                    callbackSuccess(enCryptoUrl, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
}

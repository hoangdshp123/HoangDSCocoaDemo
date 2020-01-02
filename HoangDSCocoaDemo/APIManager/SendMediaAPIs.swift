//
//  SendMediaAPIs.swift
//  MyViettelPost
//
//  Created by Hoàng Minh Thành on 8/14/18.
//  Copyright © 2018 ViettelPost. All rights reserved.
//

import Foundation
import Alamofire

class SendMediaAPIs {
    class func uploadImage(imageData: Data, imageName: String, success: @escaping (String?) -> Void, failed: @escaping (String) -> Void) {
        let url = "https://io.viettelpost.vn" + K.Path.sendMedia
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "file", fileName: imageName, mimeType: "image/jpeg")
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: ["Content-type": "multipart/form-data", "Authorization": "Bearer \(User.shared.tokenKey)", "User-Agent": Util.getUserAgent()]) { (result) in
            switch result {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (response) in
                        if let data = response.result.value as? [String: Any], let imageURL = data["url"] as? String {
                            success(imageURL)
                        } else {
                            failed("Đã có lỗi xảy ra")
                        }
                    })
                case .failure(let error):
//                    DEBUGLog(error.localizedDescription)
                    failed(error.localizedDescription)
            }
        }
    }
    
    class func sendMediaMessage(topic: String, imageURL: String, success: @escaping () -> Void, failed: @escaping () -> Void) {
        let params: Parameters = ["content": imageURL, "contentType": "image/png"]
        BaseRequest.sharedInstance.postAPI("", param: params, replaceUrl: K.baseOTTUrl + "/topic/\(topic)", header: ["Authorization": "Bearer \(User.shared.tokenKey)", "Content-Type": "application/json", "User-Agent": Util.getUserAgent()]) { (response, isSuccess, error) in
            if isSuccess {
                success()
            } else {
                failed()
            }
        }
    }
}

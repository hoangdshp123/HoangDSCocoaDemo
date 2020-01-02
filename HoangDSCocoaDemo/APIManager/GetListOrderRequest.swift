////
////  GetListOrderRequest.swift
////  MyViettelPost
////
////  Created by TunTruong on 3/22/18.
////  Copyright © 2018 PPCLink. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//class GetlistOrderRequest{
//    open class MyServerTrustPolicyManager: ServerTrustPolicyManager {
//        open override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
//            return ServerTrustPolicy.disableEvaluation
//        }
//    }
//    static var manager = Alamofire.SessionManager(delegate:SessionDelegate(), serverTrustPolicyManager:MyServerTrustPolicyManager(policies: [:]))
//        = { // Create the server trust policies
//            let serverTrustPolicies: [String: ServerTrustPolicy] = [
//                "https://api.viettelpost.vn": .disableEvaluation
//            ]
//            // Create custom manager
//            let configuration = URLSessionConfiguration.default
//            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//            return Alamofire.SessionManager(
//                configuration: URLSessionConfiguration.default,
//                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//            )
//    }()
//}


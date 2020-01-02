//
//  LoginType.swift
//  MyViettelPost
//
//  Created by Hoàng Minh Thành on 11/7/19.
//  Copyright © 2019 ViettelPost. All rights reserved.
//

import Foundation

enum LoginType {
    case facebook
    case viettel
    case email
    case FBGG
    case fb
    case gg
    case cellular
    case otp
    case none
    
    var key: String {
        get { return String(describing: self) }
    }
    
    static func login(type: LoginType) -> String {
        switch type {
        case .facebook:
            return "facebook"
        case .viettel:
            return "viettel"
        case .email:
            return "email"
        case .FBGG:
            return "FBGG"
        case .fb:
            return "fb"
        case .gg:
            return "gg"
        case .cellular:
            return "cellular"
        case .otp:
            return "otp"
        case .none:
            return ""
        }
    }
}

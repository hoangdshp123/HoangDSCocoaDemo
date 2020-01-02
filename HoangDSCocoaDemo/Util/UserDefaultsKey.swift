//
//  UserDefaultsKey.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 6/9/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//
import Foundation

let kRules = "kRules\(User.shared.userId)"
let kLogin = "Login"
let kLoginType = "LoginType"
let kURLDeepLink = "kURLDeepLink"
let kEmailUser = "kEmailUser"
let kPhoneUser = "kPhoneUser"
let kURLDeepLinkFirebase = "kURLDeepLinkFirebase"
let kCountRequestOTP = "kCountRequestOTP"
let kTimeOTP = "kTimeOTP"

// UserDefault
let kHLComplain = "kHLComplain"

enum UserDefaultKeys {
    case warehouseBookMark
    case walletDidRegistered
    case haveHistoryOrder(type: Int)
    case firstTimeUseFastOrder
    case firtTimeLogin
    case isShowIntroduce
    case pushUserInfoSaved
    case isShowRedDot
    case notificationOrderUnread
    case notificationUnread
    case userDidRateApp
    case userDidVoteOrder5Star
    case didShowTutorialOrderHistory
    case newUserShowLuclyGame
    case lastTimeRequestInviteInstall
    case invideCode
    case notShowWalletAgain
    case isShowedThreeStep
    case redirectOrderInfomation
    case gnntAbout
    case userInfoJSON
    case accountInfoJSON
    case listAccount
    
    //Tutorials
    case orderTutorial // Hướng dẫn tab đơn hàng
    case sumaryTutorial1 // Hướng dẫn tab thống kê (màn tiền hàng)
    case sumaryTutorial2 // Hướng dẫn tab tài chính (màn tiền hàng)
    case createOrderTutorial1 // Hướng dẫn tạo đơn step 1
    case createOrderTutorial2 // Hướng dẫn tạo đơn step 2
    
    case loginCount // Đếm số lần login khi để hiển thị khảo sát voso
    case createOrderCount // Đếm số lần tạo đơn để hiển thị khảo sát voso
    
    case showRatePostman // Đếm số lần hiển thị đánh giá bưu tá
    case loginCountVoteApp // Đếm số lần login để hiển thị khảo sát cảm xúc
    
    var key: String {
        switch self {
        case .warehouseBookMark:
            return "bookMarkWarehouse\(User.shared.userId)"
        case .walletDidRegistered:
            return "registered\(User.shared.userId)"
        case .haveHistoryOrder(type: let typeOrder):
            return "didHaveHistoryOrder\(User.shared.userId)\(typeOrder)"
        case .firstTimeUseFastOrder:
            return "fisrtTimeUseFastOrder\(User.shared.userId)"
        case .firtTimeLogin:
            return "firstTimeLogin\(User.shared.userId)"
        case .isShowIntroduce:
            return "isShowIntroduce"
        case .pushUserInfoSaved:
            return "pushUserInfoSaved"
        case .isShowRedDot:
            return "isShowRedDot"
        case .notificationOrderUnread:
            return "notificationOrderUnread\(User.shared.userId)"
        case .notificationUnread:
            return "notificationUnread\(User.shared.userId)"
        case .userDidRateApp:
            return "userDidRateApp\(User.shared.userId)"
        case .userDidVoteOrder5Star:
            return "userDidVoteOrder5Star\(User.shared.userId)"
        case .didShowTutorialOrderHistory:
            return "didShowTutorialOrderHistory\(User.shared.userId)"
        case .newUserShowLuclyGame:
            return "SHOWED_LUCKYGAME_V2"
        case .lastTimeRequestInviteInstall:
            return "lastTimeRequestInviteInstall"
        case .invideCode:
            return "inviteCode"
        case .notShowWalletAgain:
            return "notShowWalletAgain"
        case .isShowedThreeStep:
            return "isShowedThreeStep"
        case .redirectOrderInfomation:
            return "redirectOrderInfomation"
        case .gnntAbout:
            return "gnntAbout"
        case .userInfoJSON:
            return "userInfoJSON"
        case .accountInfoJSON:
            return "accountInfoJSON"
        case .orderTutorial:
            return "orderTutorial"
        case .sumaryTutorial1:
            return "sumaryTutorial1"
        case .sumaryTutorial2:
            return "sumaryTutorial2"
        case .createOrderTutorial1:
            return "createOrderTutorial1"
        case .createOrderTutorial2:
            return "createOrderTutorial2"
        case .listAccount:
            return "listAccount"
        case .loginCount:
            return "loginCount"
        case .createOrderCount:
            return "createOrderCount"
        case .showRatePostman:
            return "showRatePostman"
        case .loginCountVoteApp:
            return "loginCountVoteApp"
        }
    }
}

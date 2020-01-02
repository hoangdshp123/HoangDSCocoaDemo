//
//  User.swift
//  MyViettelPost
//
//  Created by Pham Diep on 3/23/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import UIKit
import SwiftyJSON

class User {
    static let shared = User.init()
    enum UserSex: Int {
        case male = 0
        case female = 1
    }
    var tokenKey: String = ""
    var userId: Int = 0
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var phone = ""
    var displayName = ""
    var sex: UserSex = .male
    var partner: Int = 0
    var introduction = ""
    var districtId: Int = 0
    var wardsId: Int = 0
    var address = ""
    var source: Int = 0
    var username: String?
    var role: Int?
    var fromsource: String?
//    var arrWarehouse: Results<CustomerInfoModel> {
//        let realm = try! Realm.init()
//        return realm.objects(CustomerInfoModel.self).filter("isVisible = %d", 1)
//    }
//    var currentAddress = AddressModel()
    var bankBranch = ""
    var bankAccNum = ""
    var bankUserName = ""
    var bankId = ""
    var loginType = ""
    
    var accountInfo: InfoAccount? {
        didSet {
            guard let data = accountInfo else {
                return
            }
//            do {
//                let realm = try Realm.init()
//                self.currentAddress.province = realm.object(ofType: Province.self, forPrimaryKey: String(data.PROVINCE_ID))
//                self.currentAddress.district = realm.object(ofType: District.self, forPrimaryKey: String(data.DISTRICT_ID))
//                self.currentAddress.ward = realm.object(ofType: Ward.self, forPrimaryKey: String(data.WARDS_ID))
//            } catch(_) {
//                
//            }
            
//            self.currentAddress.firstAddress = data.ADDRESS.capitalized
//            self.currentAddress.autoFillFullAddress()
        }
    }
    
    init() {}
    
    func initData(dict: JSON) {
        partner = dict["Partner"].intValue
        username = dict["UserName"].stringValue
        userId = dict["UserId"].intValue
        role = dict["Role"].intValue
        fromsource = dict["FromSource"].stringValue
        tokenKey = dict["TokenKey"].stringValue
        phone = dict["Phone"].stringValue
        email = dict["Email"].stringValue
        UserDefaults.standard.setValue(tokenKey, forKey: "accessTokenString")
        var newJSON = dict
        newJSON["LoginType"].stringValue = loginType
        newJSON["LoginStatus"].boolValue = true
        UserDefaults.standard.setValue(newJSON.rawString(), forKey: UserDefaultKeys.userInfoJSON.key)
        if username != "" || phone != "" || email != "" {
            addToListAccout(dict: newJSON)
        }
    }
    
    func updateLoginStatus(dict: JSON) {
        var newJSON = dict
        newJSON["LoginStatus"].bool = false
        if username != "" {
            addToListAccout(dict: newJSON)
        }
    }
    
    func updateToken(newToken: String) {
        if var listAccout = UserDefaults.standard.array(forKey: UserDefaultKeys.listAccount.key) as? [String] {
            for (index, account) in listAccout.enumerated() {
                var user = JSON.init(parseJSON: account)
                if user["UserId"].intValue == userId {
                    listAccout.remove(at: index)
                    user["TokenKey"].stringValue = newToken
                    listAccout.insert(user.rawString() ?? "", at: index)
                    UserDefaults.standard.setValue(newToken, forKey: "accessTokenString")
                    UserDefaults.standard.setValue(user.rawString(), forKey: UserDefaultKeys.userInfoJSON.key)
                    break
                }
            }
            UserDefaults.standard.setValue(listAccout, forKey: UserDefaultKeys.listAccount.key)
        }
    }
    
    func addToListAccout(dict: JSON) {
        if var listAccout = UserDefaults.standard.array(forKey: UserDefaultKeys.listAccount.key) as? [String] {
            var isContain : Bool = false
            for (index, account) in listAccout.enumerated() {
                let user = JSON.init(parseJSON: account)
                if user["UserId"].intValue == userId && dict.rawString() != ""{
                    listAccout.remove(at: index)
                    listAccout.insert(dict.rawString() ?? "", at: index)
                    isContain = true
                }
            }
            if !isContain {
                if dict.rawString() == "" {return}
                listAccout.append(dict.rawString() ?? "")
            }
            UserDefaults.standard.setValue(listAccout, forKey: UserDefaultKeys.listAccount.key)
        } else if dict.rawString() != ""{
            var listAccout :[String] = []
            if dict.rawString() == "" {return}
            listAccout.append(dict.rawString() ?? "")
            UserDefaults.standard.setValue(listAccout, forKey: UserDefaultKeys.listAccount.key)
        }
    }
    
    init(dict: JSON) {
       initData(dict: dict)
    }
    
    func updateAccountInfo(dictFromGetInfo: JSON) {
        username = dictFromGetInfo["EMAIL"].string ?? dictFromGetInfo["PHONE"].string
        firstName = dictFromGetInfo["FIRSTNAME"].stringValue
        lastName = dictFromGetInfo["LASTNAME"].stringValue
        email = dictFromGetInfo["EMAIL"].stringValue
        phone = dictFromGetInfo["PHONE"].stringValue
        userId = dictFromGetInfo["CUS_ID"].intValue
        displayName = lastName + " " + firstName
        bankUserName = dictFromGetInfo["REPRESENT"].stringValue
        bankId = dictFromGetInfo["LISTBANK_ID"].stringValue
        bankBranch = dictFromGetInfo["BANK_BRANCH"].stringValue
        bankAccNum = dictFromGetInfo["ACCOUNTNO"].stringValue
    }
    
    func updateAccountFromFBGG(json: JSON) {
        tokenKey = json["TokenKey"].stringValue
//        UserDefaults.standard.set(tokenKey, forKey: "tokenString")
        UserDefaults.standard.set(tokenKey, forKey: "accessTokenString")
        userId = json["UserId"].intValue
        firstName = json["accountInfo"]["FIRSTNAME"].stringValue
        lastName = json["accountInfo"]["LASTNAME"].stringValue
        email = json["accountInfo"]["EMAIL"].stringValue
        phone = json["Phone"].stringValue
        displayName = json["accountInfo"]["DISPLAYNAME"].stringValue
        partner = json["Partner"].intValue
        introduction = json["accountInfo"]["INTRODUCTION"].stringValue
        districtId = json["accountInfo"]["DISTRICT_ID"].intValue
        wardsId = json["accountInfo"]["WARDS_ID"].intValue
        address = json["accountInfo"]["ADDRESS"].stringValue
        username = json["UserName"].stringValue
        role = json["Role"].intValue
        fromsource = json["FromSource"].stringValue
        bankBranch = json["accountInfo"]["BANK_BRANCH"].stringValue
        bankAccNum = json["accountInfo"]["ACCOUNTNO"].stringValue
        bankUserName = json["accountInfo"]["REPRESENT"].stringValue
        bankId = json["accountInfo"]["LISTBANK_ID"].stringValue
        var newJSON = json
        newJSON["LoginType"].stringValue = loginType
        newJSON["isLoggedOut"].boolValue = false
        UserDefaults.standard.setValue(newJSON.rawString(), forKey: UserDefaultKeys.userInfoJSON.key)
        if districtId != 0 {
           addToListAccout(dict: json)
        }
    }
    
    func loadUserDataFromCache() {
        if let userJSON = UserDefaults.standard.string(forKey: UserDefaultKeys.userInfoJSON.key) {
            if UserDefaults.standard.value(forKey: "accessTokenString") == nil {
                User.shared.tokenKey = ""
            } else {
                let json = JSON.init(parseJSON: userJSON)
                User.shared.initData(dict: json)
            }
        }
        if let accountJSON = UserDefaults.standard.string(forKey: UserDefaultKeys.accountInfoJSON.key) {
            let json = JSON.init(parseJSON: accountJSON)
            let accountInfo = InfoAccount.init(dict: json)
            User.shared.accountInfo = accountInfo
            User.shared.updateAccountInfo(dictFromGetInfo: json)
            User.shared.displayName = "\(accountInfo.LASTNAME) \(accountInfo.FIRSTNAME)"
            User.shared.districtId = Int(accountInfo.DISTRICT_ID)
            User.shared.wardsId = Int(accountInfo.WARDS_ID)
            User.shared.phone = accountInfo.PHONE
            User.shared.tokenKey = UserDefaults.standard.string(forKey: "accessTokenString") ?? ""
        }
    }
}

class AccountWallet {
    enum AccountStatus: Int {
        case hasPassword = 102
        case notYetHasPassword = 107
        case accInValidate = -2
    }
    static let shared = AccountWallet.init()
    init() {
        
    }
    func initData(json: JSON) {
        id = json["id"].stringValue
        modifiedTimestamp = json["modifiedTimestamp"].doubleValue
        status = json["status"].intValue
        source = json["source"].intValue
        rewards = json["rewards"].intValue
        balance = json["balance"].intValue
        lastUpdateToken = json["lastUpdatedToken"].doubleValue
        gender = json["gender"].intValue
        role = json["roles"].intValue
        email = json["email"].stringValue
        token = json["token"].stringValue
        phone = json["phone"].stringValue
        userName = json["username"].stringValue
    }
    var id = ""
    var modifiedTimestamp: Double = 0
    var status: Int = 0
    var source: Int = 0
    var rewards: Int = 0
    var balance: Int = 0
    var bonusBalance: Int = 0
    var creditBalance: Int = 0
    var lastUpdateToken: Double = 0
    var gender: Int = 0
    var role: Int = 0
    var email: String = ""
    var token: String = ""
    var phone: String = ""
    var userName: String = ""
    var transactions = [Transactions]()
    var accStatus: AccountStatus = .accInValidate
    
    func updateBalanceInfo(json: JSON) {
        
        balance = json["longValue1"].intValue
        bonusBalance = json["longValue2"].intValue
        creditBalance = json["longValue3"].intValue
        transactions.removeAll()
        for jsonTrans in json["listTransData"].arrayValue.reversed() {
            transactions.append(Transactions(dict: jsonTrans))
        }
    }
    
    var displayBalance: Int {
        if balance == 0 {
            return bonusBalance
        } else {
            return balance
        }
    }
    
    var totalBalance: Int {
        return balance + bonusBalance + creditBalance
    }
  
}

struct Transactions {
    //type: 1 là chuyển khoản
    // 0: nếu amount > 0 là nạp tiền, <= 0 là thanh toán
    var id: String!
    var transId: String!
    var fromUserId: String!
    var toUserId: String!
    var toUserPhone: String = ""
    var toUserName = ""
    var amount: Int!
    var type: Int!
    var content: String!
    var note: String!
    var status: Int!
    var userId: String!
    var transTimestamp: Double!
    var actionTimestamp: Double!
   
    
    init(dict: JSON) {
        id = dict["id"].stringValue
        transId = dict["transId"].stringValue
        fromUserId = dict["fromUserId"].stringValue
        toUserId = dict["toUserId"].stringValue
        amount = dict["amount"].intValue
        type = dict["type"].intValue
        content = dict["content"].stringValue
        note = dict["note"].stringValue
        status = dict["status"].intValue
        userId = dict["userId"].stringValue
        transTimestamp = dict["transTimestamp"].doubleValue
        actionTimestamp = dict["actionTimestamp"].doubleValue
    }
}

//
//  Config.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 4/2/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Foundation
import SwiftyJSON

struct InfoAccount {
    let CUS_ID: String
    let FIRSTNAME: String
    let LASTNAME: String
    let EMAIL: String
    let PHONE: String
    let DISPLAYNAME: String
    let REPRESENT: String
    let BIRTHDATE: String
    let SEX: String
    let IDENTIFIERNUMBER: String
    let IDENTIFIERCREATEONDATE: String
    let IDENTIFIERISSUEDBY: String
    let IDENTIFIERPHOTOPATH: String
    let PASSPORTNUMBER: String
    let PASSPORTPHOTOPATH: String
    let PHOTOPATH: String
    let POST_ID: String
    let INTRODUCTION: String
    let PROVINCE_ID: Int!
    let DISTRICT_ID: Int!
    let WARDS_ID: Int
    let ADDRESS: String
    let ADDRESS_INVOICE: String
    let LISTBANK_ID: Int!
    let BANK_BRANCH: String
    let ACCOUNTNO: String
    let DESCRIPTION: String
    let CREDITLIMIT: String
    let TAX_CODE: Int
    var AVATAR: String
    let MARKETING_STAFF: String
    let CREATEDBYUSERID: Int!
    let CREATEDONDATE: String
    let LASTMODIFIEDBYUSERID: String
    let LASTMODIFIEDONDATE: String
    var EMAIL_VALIDATED: Int = 0
    var PHONE_VALIDATED: Int = 0
    
    init(dict: JSON) {
        CUS_ID = dict["CUS_ID"].stringValue
        FIRSTNAME = dict["FIRSTNAME"].stringValue
        LASTNAME = dict["LASTNAME"].stringValue
        EMAIL = dict["EMAIL"].stringValue
        PHONE = dict["PHONE"].stringValue
        DISPLAYNAME = dict["DISPLAYNAME"].stringValue
        REPRESENT = dict["REPRESENT"].stringValue
        BIRTHDATE = dict["BIRTHDATE"].stringValue
        SEX = dict["SEX"].stringValue
        IDENTIFIERNUMBER = dict["IDENTIFIERNUMBER"].stringValue
        IDENTIFIERCREATEONDATE = dict["IDENTIFIERCREATEONDATE"].stringValue
        IDENTIFIERISSUEDBY = dict["IDENTIFIERISSUEDBY"].stringValue
        IDENTIFIERPHOTOPATH = dict["IDENTIFIERPHOTOPATH"].stringValue
        PASSPORTNUMBER = dict["PASSPORTNUMBER"].stringValue
        PASSPORTPHOTOPATH = dict["PASSPORTPHOTOPATH"].stringValue
        PHOTOPATH = dict["PHOTOPATH"].stringValue
        POST_ID = dict["POST_ID"].stringValue
        INTRODUCTION = dict["INTRODUCTION"].stringValue
        PROVINCE_ID = dict["PROVINCE_ID"].intValue
        DISTRICT_ID = dict["DISTRICT_ID"].intValue
        WARDS_ID = dict["WARDS_ID"].intValue
        ADDRESS = dict["ADDRESS"].stringValue
        ADDRESS_INVOICE = dict["ADDRESS_INVOICE"].stringValue
        LISTBANK_ID = dict["LISTBANK_ID"].intValue
        BANK_BRANCH = dict["BANK_BRANCH"].stringValue
        ACCOUNTNO = dict["ACCOUNTNO"].stringValue
        DESCRIPTION = dict["DESCRIPTION"].stringValue
        CREDITLIMIT = dict["CREDITLIMIT"].stringValue
        TAX_CODE = dict["TAX_CODE"].intValue
        AVATAR = dict["AVATAR"].stringValue
        MARKETING_STAFF = dict["MARKETING_STAFF"].stringValue
        CREATEDBYUSERID = dict["CREATEDBYUSERID"].intValue
        CREATEDONDATE = dict["CREATEDONDATE"].stringValue
        LASTMODIFIEDBYUSERID = dict["LASTMODIFIEDBYUSERID"].stringValue
        LASTMODIFIEDONDATE = dict["LASTMODIFIEDONDATE"].stringValue
        EMAIL_VALIDATED = dict["EMAIL_VALIDATED"].intValue
        PHONE_VALIDATED = dict["PHONE_VALIDATED"].intValue
    }
}

struct ListBank {
    let CODE: Int
    let NAME: String
    let DESCRIPTION: String
    let TYPE: Int
    let POS: Int
    
    init(dict: JSON) {
        CODE = dict["CODE"].intValue
        NAME = dict["NAME"].stringValue
        DESCRIPTION = dict["DESCRIPTION"].stringValue
        TYPE = dict["TYPE"].intValue
        POS = dict["POS"].intValue
    }
}

struct ListStaff {
    let CUS_ID: Int
    let PARENT_ID: Int
    let GROUPADDRESS_ID: Int
    let IS_TYPE: Int
    let IS_ACTIVE: Int
    let IS_ROLE: Int
    let SYSTEM_DATE: String
    let SETTING_PATH: String
    let NAME: String
    let EMAIL: String
    let PHONE: String
    let ADDRESS: String
    let STATUS_NAME: String
    
    init(dict: JSON) {
        CUS_ID = dict["CUS_ID"].intValue
        PARENT_ID = dict["PARENT_ID"].intValue
        GROUPADDRESS_ID = dict["GROUPADDRESS_ID"].intValue
        IS_TYPE = dict["IS_TYPE"].intValue
        IS_ACTIVE = dict["IS_ACTIVE"].intValue
        IS_ROLE = dict["IS_ROLE"].intValue
        SYSTEM_DATE = dict["SYSTEM_DATE"].stringValue
        SETTING_PATH = dict["SETTING_PATH"].stringValue
        NAME = dict["NAME"].stringValue
        EMAIL = dict["EMAIL"].stringValue
        PHONE = dict["PHONE"].stringValue
        ADDRESS = dict["ADDRESS"].stringValue
        STATUS_NAME = dict["STATUS_NAME"].stringValue
    }
}

extension ListStaff {
    var isApproved: Bool {
        return STATUS_NAME == "Đã duyệt"
    }
}

struct CusPayment {
    let DESCRIPTION: String
    let PERIOD_PAYMENT: String
    let TYPE_PAY: String
    let PAYMENT_TEAM: String
    
    init(dict: JSON) {
        DESCRIPTION = dict["DESCRIPTION"].stringValue
        PERIOD_PAYMENT = dict["PERIOD_PAYMENT"].stringValue
        TYPE_PAY = dict["TYPE_PAY"].stringValue
        PAYMENT_TEAM = dict["PAYMENT_TEAM"].stringValue
    }
}

struct Setting {
    let chat: Bool
    let news: Bool
    let successOrder: Bool
    let returnOrder: Bool
    
    init(dict: JSON) {
        chat = dict["chat"].boolValue
        news = dict["news"].boolValue
        successOrder = dict["successOrder"].boolValue
        returnOrder = dict["returnOrder"].boolValue
    }
}

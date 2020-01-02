//
//  File.swift
//  MyViettelPost
//
//  Created by Mac on 2/27/19.
//  Copyright © 2019 ViettelPost. All rights reserved.
//

import Foundation
import SiFUtilities
import SwiftyJSON

struct SettingDefault {
    let CUS_ID: String?
    let AUTO_SELECT_COD: Bool?
    var DEFAULT_SERVICE: String?
    var TIME_DELIVERY_CODE: Int?
    let NOTE_DELIVERY: Int?
    let OPTION_GET_ORDER: Int?
    let PRODUCT_NAME: String?
    let PRODUCT_WEIGHT: Int?
    let PRODUCT_QUANTITY: Int?
    var SHOW_TUTORIAL: Bool?
    
    init(dict: JSON) {
        CUS_ID = dict["CUS_ID"].stringValue
        AUTO_SELECT_COD = dict["AUTO_SELECT_COD"].boolValue
        DEFAULT_SERVICE = dict["DEFAULT_SERVICE"].stringValue
        TIME_DELIVERY_CODE = dict["TIME_DELIVERY_CODE"].intValue
        NOTE_DELIVERY = dict["NOTE_DELIVERY"].intValue
        OPTION_GET_ORDER = dict["OPTION_GET_ORDER"].intValue
        PRODUCT_NAME = dict["PRODUCT_NAME"].stringValue
        PRODUCT_WEIGHT = dict["PRODUCT_WEIGHT"].intValue
        PRODUCT_QUANTITY = dict["PRODUCT_QUANTITY"].intValue
        SHOW_TUTORIAL = dict["SHOW_TUTORIAL"].bool
    }
    
    init() {
        CUS_ID = nil
        AUTO_SELECT_COD = nil
        DEFAULT_SERVICE = nil
        TIME_DELIVERY_CODE = nil
        NOTE_DELIVERY = nil
        OPTION_GET_ORDER = nil
        PRODUCT_NAME = nil
        PRODUCT_WEIGHT = nil
        PRODUCT_QUANTITY = nil
        SHOW_TUTORIAL = nil
    }
}

//
//  Transporter.swift
//  MyViettelPost
//
//  Created by Pham Diep on 6/13/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import UIKit
import SwiftyJSON

class Transporter: NSObject {
    var transId = ""
    var maNhanVien = ""
    var phone = ""
    var firstName = ""
    var lastName = ""
    var fullName: String {
        if firstName != "" {
            return lastName + " " + firstName
        } else if lastName != "" {
            return lastName
        } else {
            return "Chưa xác định"
        }
    }
    var rate: Int = 0
    
    init(dict: JSON) {
        super.init()
        maNhanVien = dict["MANHANVIEN"].stringValue
        transId = dict["USERID"].stringValue
        phone = dict["TELEPHONE"].stringValue
        firstName = dict["FIRSTNAME"].stringValue
        lastName = dict["LASTNAME"].stringValue
    }
    
//    "TELEPHONE": "84976261288",
//    "ACTIVE": 1,
//    "PTYPE": 1,
//    "MANHANVIEN": "014926",
//    "FIRSTNAME": "Phạm Thống",
//    "DN_USERID": 4214,
//    "TEL2": null,
//    "TEL1": null,
//    "LASTNAME": "Soái",
//    "MA_CHUCDANH": "VTB009",
//    "IS_VIEW": 1,
//    "USERID": 100979,
//    "USERNAME": "soaipt",
//    "ISSMSVIETNAM": 0,
//    "MA_BUUCUC": "TN2",
//    "TEL3": null
}

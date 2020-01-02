//
//  ConfigAPIs.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 4/2/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import KRProgressHUD

class ConfigAPIs {
    private static let SSOKey = "tw498twe89th238Ar5y98erfwsbvsagsdfepiafklE98rbhq38r543890314123rusdf87bq38972438r4378461237eryqwrf9b"

    // MARK: - Lấy thông tin tài khoản. Thông tin cá nhân.
    
    class func getInfoAccount(success callbackSuccess: @escaping (_ infoAccount: [InfoAccount]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI(urlGetInfoAccount, param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                User.shared.updateAccountInfo(dictFromGetInfo: jsonResponse!.arrayValue.first ?? JSON(parseJSON: ""))
                UserDefaults.standard.set(User.shared.phone, forKey: "phoneString")
                
                var infoAccount = [InfoAccount]()
                for jsonInfoAccount in jsonResponse!.arrayValue {
                    infoAccount.append(InfoAccount(dict: jsonInfoAccount))
                }
                
                if let dataUser = infoAccount.first {
                    User.shared.accountInfo = dataUser
                    UserDefaults.standard.set(dataUser.EMAIL, forKey: kEmailUser)
                    UserDefaults.standard.set(dataUser.PHONE, forKey: kPhoneUser)
                }
                
                callbackSuccess(infoAccount)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func getAccountInfo(success callbackSuccess: @escaping (_ infoAccount: [InfoAccount]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI(urlGetAccountInfo, param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                User.shared.updateAccountInfo(dictFromGetInfo: jsonResponse!.arrayValue.first ?? JSON(parseJSON: ""))
                UserDefaults.standard.set(User.shared.phone, forKey: "phoneString")
                
                var infoAccount = [InfoAccount]()
                for jsonInfoAccount in jsonResponse!.arrayValue {
                    infoAccount.append(InfoAccount(dict: jsonInfoAccount))
                }
                
                if let dataUser = infoAccount.first {
                    User.shared.accountInfo = dataUser
                    UserDefaults.standard.set(dataUser.EMAIL, forKey: kEmailUser)
                    UserDefaults.standard.set(dataUser.PHONE, forKey: kPhoneUser)
                    if var firstJSON = jsonResponse?.arrayValue.first {
                        firstJSON["LoginType"].stringValue = User.shared.loginType
                        UserDefaults.standard.setValue(firstJSON.rawString(), forKey: UserDefaultKeys.accountInfoJSON.key)
                    }
                }
                callbackSuccess(infoAccount)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func getAccountInfoSSO(userId: String, ssoToken: String? = nil, success callbackSuccess: @escaping (_ infoAccount: [InfoAccount]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.postAPI(urlGetAccountInfoSSO, param: ["TokenSSO": (ssoToken ?? UserDefaults.standard.value(forKey: "TokenSSO_\(userId)") ?? ""), "Type": "OVERRIDE", "deviceId":UIDevice.current.identifierForVendor?.uuidString ?? ""]) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                User.shared.updateAccountInfo(dictFromGetInfo: jsonResponse!.arrayValue.first ?? JSON(parseJSON: ""))
                UserDefaults.standard.set(User.shared.phone, forKey: "phoneString")
                
                var infoAccount = [InfoAccount]()
                for jsonInfoAccount in jsonResponse!.arrayValue {
                    infoAccount.append(InfoAccount(dict: jsonInfoAccount))
                }
                
                if let dataUser = infoAccount.first {
                    User.shared.accountInfo = dataUser
                    UserDefaults.standard.set(dataUser.EMAIL, forKey: kEmailUser)
                    UserDefaults.standard.set(dataUser.PHONE, forKey: kPhoneUser)
                    if var firstJSON = jsonResponse?.arrayValue.first {
                        firstJSON["LoginType"].stringValue = User.shared.loginType
                        UserDefaults.standard.setValue(firstJSON.rawString(), forKey: UserDefaultKeys.accountInfoJSON.key)
                    }
                }
                callbackSuccess(infoAccount)
            } else {
            }
        }
    }
    
    class func getAvatar(success callbackSuccess: @escaping (String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.postAPI(K.Path.getAvatar, param: nil) { (jsonResponse, isSuccess, error) in
            if isSuccess {
                if let response = jsonResponse {
                    callbackSuccess(response["data"]["AVATAR_STRING"].stringValue)
                } else {
                    callbackFailure(error ?? "")
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    // MARK: - Cập nhật tài khoản
    
    class func updateInfoAccount(FIRST_NAME: String, LAST_NAME: String, DISPLAYNAME: String, PROVINCE_ID: String, DISTRICT_ID: String, WARDS_ID: String, ADDRESS: String, BIRTHDATE: String, PASSPORTNUMBER: String, success callbackSuccess: @escaping (_ status: Int, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kFIRST_NAME: FIRST_NAME, kLAST_NAME: LAST_NAME, kDISPLAYNAME: DISPLAYNAME, kPROVINCE_ID: PROVINCE_ID, kDISTRICT_ID: DISTRICT_ID, kWARDS_ID: WARDS_ID, kADDRESS: ADDRESS, kBIRTHDATE: BIRTHDATE, kPASSPORTNUMBER: PASSPORTNUMBER]
        
        BaseRequest.sharedInstance.postAPI(urlUpdateInfoAccount, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Đặt mật khẩu
    
    class func setPassword(newPassword: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [pID: User.shared.userId, pPWD: newPassword]
        BaseRequest.sharedInstance.postAPI(urlSetPassword, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func sendOTPMail(userId: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [pID: userId]
        BaseRequest.sharedInstance.getAPI(urlSendOTPEmail, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func validateMail(email: String, otp: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = ["EMAIL": email, "OTP": otp]
        BaseRequest.sharedInstance.postAPI(urlValidateEmail, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                if error {
                    callbackFailure(message)
                } else {
                    callbackSuccess(status, error, message)
                }
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Thay đổi mật khẩu.
    
    class func changePassword(oldPassword: String, newPassword: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kPASSWORD_OLD: oldPassword, kPASSWORD_NEW: newPassword]
        
        BaseRequest.sharedInstance.postAPI(urlChangePassword, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Lấy danh sách ngân hàng.
    
    class func getBankList(limit: String, success callbackSuccess: @escaping (_ listBank: [ListBank]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI("\(urlGetListBank)\(limit)", param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                var listBank = [ListBank]()
                for jsonListBank in jsonResponse!.arrayValue {
                    listBank.append(ListBank(dict: jsonListBank))
                }
                callbackSuccess(listBank)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Lấy danh sách bưu cục
    
//    class func getListBuuCucVTP(success callbackSuccess: @escaping (_ listBank: [PostOffices]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
//        BaseRequest.sharedInstance.getAPI("\(urlListBuuCucVTP)", param: nil) { jsonResponse, isSuccess, error in
//            if isSuccess {
//                var postOffices = [PostOffices]()
//                for jsonPostOffices in jsonResponse!["data"].arrayValue {
//                    postOffices.append(PostOffices(dict: jsonPostOffices))
//                }
//                callbackSuccess(postOffices)
//            } else {
//                callbackFailure(error!)
//            }
//        }
//    }
    
    // MARK: - Cập nhật thông tin tài khoản ngân hàng.
    
    class func updateBankInfo(BANKID: String, BRANCH: String, REPRESENT: String, BANKNUMBER: String, success callbackSuccess: @escaping (_ status: Int, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kBANKID: BANKID, kBRANCH: BRANCH, kREPRESENT: REPRESENT, kBANKNUMBER: BANKNUMBER]
        
        BaseRequest.sharedInstance.postAPI(urlUpdateBankInfo, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Lấy danh sách nhân viên.
    
    class func getListStaff(invenID: String, success callbackSuccess: @escaping (_ listStaff: [ListStaff]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI("\(urlGetListStaff)\(invenID)", param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                var listStaff = [ListStaff]()
                for jsonListStaff in jsonResponse!.arrayValue {
                    let staffObj = ListStaff(dict: jsonListStaff)
                    if staffObj.NAME == "" || staffObj.ADDRESS == "" || staffObj.PHONE == "" {
                    } else {
                        listStaff.append(ListStaff(dict: jsonListStaff))
                    }
                }
                callbackSuccess(listStaff)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Tìm kiếm nhân viên.
    
    class func searchStaff(key: String, success callbackSuccess: @escaping (_ searchStaff: [InfoAccount]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI("\(urlSearchStaff)\(key)", param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                var searchStaff = [InfoAccount]()
                for jsonSearchStaff in jsonResponse!.arrayValue {
                    searchStaff.append(InfoAccount(dict: jsonSearchStaff))
                }
                callbackSuccess(searchStaff)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Thêm nhân viên vào danh sách cấu hình.
    
    class func createAddressChild(cus_id: String, success callbackSuccess: @escaping (_ createAddressChild: Int) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kCUS_ID: cus_id]
        
        BaseRequest.sharedInstance.postAPI(urlCreateAddressChild, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                callbackSuccess(status)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Lấy dữ liệu phương thức thanh toán.
    
    class func getCusPayment(success callbackSuccess: @escaping (_ cusPayment: [CusPayment]) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        BaseRequest.sharedInstance.getAPI(urlGetCusPayment, param: nil) { jsonResponse, isSuccess, error in
            if isSuccess {
                var cusPayment = [CusPayment]()
                for jsonCusPayment in jsonResponse!.arrayValue {
                    cusPayment.append(CusPayment(dict: jsonCusPayment))
                }
                callbackSuccess(cusPayment)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    // MARK: - Cập nhật phương thức thanh toán.
    
    class func updateKiDoiSoat(TYPE: String, PAYMENT: String, PAYTYPE: String, success callbackSuccess: @escaping (_ status: Int, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kTYPE: TYPE, kPAYMENT: PAYMENT, kPAYTYPE: PAYTYPE]
        
        BaseRequest.sharedInstance.postAPI(urlUpdateKiDoiSoat, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func updateSocicalInfo(PHONE: String, EMAIL: String, DISPLAYNAME: String, FIRSTNAME: String, LASTNAME: String, ADDRESS: String, PROVINCE_ID: String, DISTRICT_ID: String, WARDS_ID: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let parameter: Parameters = [kPHONE: PHONE,
                                     kEMAIL: EMAIL,
                                     kDISPLAYNAME: DISPLAYNAME,
                                     kFIRST_NAME: FIRSTNAME,
                                     kLAST_NAME: LASTNAME,
                                     kADDRESS: ADDRESS,
                                     kPROVINCE_ID: PROVINCE_ID,
                                     kDISTRICT_ID: DISTRICT_ID,
                                     kWARDS_ID: WARDS_ID]
        
        print(parameter)
        BaseRequest.sharedInstance.postAPI(urlUpdateSocicalInfo, param: parameter) { jsonResponse, isSuccess, error in
            if isSuccess {
                let status = jsonResponse!["status"].intValue
                let error = jsonResponse!["error"].boolValue
                let message = jsonResponse!["message"].stringValue
                callbackSuccess(status, error, message)
            } else {
                callbackFailure(error!)
            }
        }
    }
    
    class func updateAvatar(userID: Int, avatar: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["AVATAR_STRING": avatar, "CUS_ID": userID]
        BaseRequest.sharedInstance.postAPI(K.Path.updateAvatar, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    class func getAppCreateOrderSettings(userID: Int, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String, _ setting: SettingDefault) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["cusId": userID]
        BaseRequest.sharedInstance.getAPI(K.Path.getAppCreateOrderSettings, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let settingDefault = SettingDefault(dict: json["data"])
                UserDefaults.standard.setValue(json["data"].rawString(), forKey: "Setting_\(User.shared.userId)")
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message, settingDefault)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
    class func saveAppCreateOrderSettings(params: Parameters, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
      //  let params: Parameters = ["cusId": userID]
        BaseRequest.sharedInstance.postAPI(K.Path.saveAppCreateOrderSettings, param: params) { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    callbackSuccess(status, error, message)
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
    
     // MARK: - Cập nhật SSO login
    
    class func updateSSO(token: String, idToken: String, success callbackSuccess: @escaping (_ status: Int, _ error: Bool, _ message: String, JSON) -> Void, failed callbackFailure: @escaping (_ message: String) -> Void) {
        let params: Parameters = ["Source": 2, "Key": SSOKey, "TokenSSO": token, "TokenIdSSO": idToken, "Type": "VTP"]
        //"http://171.244.50.223:8443\(K.Path.ssoUpdater)"
        BaseRequest.sharedInstance.postAPI(K.Path.ssoUpdater, param: params, replaceUrl: "") { response, isSuccess, error in
            if let json = response {
                let status = json["status"].intValue
                let message = json["message"].stringValue
                let error = json["error"].boolValue
                if isSuccess {
                    User.shared.initData(dict: json["data"])
                    callbackSuccess(status, error, message, json["data"])
                } else {
                    callbackFailure(message)
                }
            } else {
                callbackFailure(error ?? "")
            }
        }
    }
}

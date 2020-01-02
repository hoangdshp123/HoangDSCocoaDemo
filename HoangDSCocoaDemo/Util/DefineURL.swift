//
//  DefineURL.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 4/2/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Foundation

let BaseURL = "https://api.viettelpost.vn/"

// MARK: - BuuCucVTP

let urlListBuuCucVTP = "/api/setting/listBuuCucVTPNew"

// MARK: - Login Facebook

let urlLoginFB = "/api/user/LoginFB"

// MARK: - Login Web

let urlLoginWeb = "/api/setting/approveQRToken"

// MARK: - User

let urlResetPassword = "/api/user/resetPassword?username="
let urlUpdatePassword = "/api/user/updatePassword"
let urlSendSMSLogin = "/api/user/sendSMSLogin"
let urlLoginSMS = "/api/user/LoginSMS"
let urlSaveUserPublic = "/api/user/saveUserPublic"
let urlUpdatePhoneNumber = "/api/setting/updatePhoneNumber"
// MARK: - Forget pass new version
let urlForgetEmail = "/api/user/forgetEmailOTP"
let newUrlUpdatePassword = "/api/user/updatePasswordNew"
let urlGetCapcha = "/api/user/captchaEmailOTP"
let urlCapchaVerification = "/api/user/captchaPhoneVerification"

// Capcha
let getCapcha = "/captcha"
let loginWithCapcha = "/login"

// MARK: - ConfigAPIs

let urlGetInfoAccount = "/api/setting/getInfoAccount"
let urlGetAccountInfo = "/api/setting/getAccountInfo"
let urlGetAccountInfoSSO = "/api/setting/getAccountInfoSSO"
let urlUpdateInfoAccount = "/api/setting/UpdateInfoAccount"
let urlChangePassword = "/api/setting/ChangePassword"
let urlSendOTPEmail = "/api/user/sendEmailValidate"
let urlValidateEmail = "/api/user/validateOtpEmail"
let urlSettingValidateEmail = "/api/setting/validateEmail"
let urlSetPassword = "/api/setting/setUpPassword"
let urlGetListBank = "/api/setting/listCategories?type="
let urlGetListStaff = "/api/setting/listStaff?GroupAddressID="
let urlSearchStaff = "/api/setting/getInfoAccountByUsername?username="
let urlCreateAddressChild = "/api/setting/CreateAddressChild"
let urlUpdateBankInfo = "/api/setting/UpdateBankInfo"
let urlUpdateKiDoiSoat = "/api/setting/UpdateKiDoiSoat"
let urlGetCusPayment = "/api/setting/getCusPayment"
let urlUpdateSocicalInfo = "/api/setting/updateSocicalInfo"

// MARK: - InventoryAPIs

let urlListInventory = "/api/setting/listInventory"
let urlCreateUpdateInventory = "/api/setting/CreateUpdateInventory"
let urlListStaffActive = "/api/setting/listStaffActive"
let urlAddStaffToInventory = "/api/setting/AddStaffToInventory"

// MARK: - ComplainAPIs

let urlListComplain = "/api/Complain/listComplain"
let urlCreateComplain = "/api/Complain/CreateComplain"

// MARK: - EvaluateAPIs

let urlListRateGroup = "/api/Complain/listRateGroup"
let urlListRate = "/api/Complain/listRate"
let urlInsertCusRateDetail = "/api/Complain/insertCusRateDetail"

// MARK: - BillingAPIs

let urlListAllTypeXe = "/api/Transport/listAllTypeXe"
let urlGetTransportPrice = "/api/Transport/getTransportPrice"

//// MARK: - viettelpost API analytic.
// let urlAnalytic = "/api/user/affiliate"

// MARK: - Game Shake Hand

let luckygame = "/luckygame/v1.0/luckygame"

// MARK: - Setting

let urlSetting = "/setting"

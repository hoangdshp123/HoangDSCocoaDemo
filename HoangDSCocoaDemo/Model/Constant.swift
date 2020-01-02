//
//  Constant.swift
//  MyViettelPost
//
//  Created by Pham Diep on 3/21/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Foundation

let countDownOtp: Int = 60

let maxLength1 = 1
let maxLength4 = 4
let maxLength8 = 8
let maxLength15 = 15
let maxLength20 = 20
let maxLength30 = 30
let maxLength50 = 50
let maxLength150 = 150
let maxLength200 = 200
let maxLength1000 = 1000

// MARK: - App constant config

let phoneSupport = "19008095"
let servicesRequireProductSize: [String] = ["VBS", "VBE"]
let minTimeUsedToShowInPopular: Int = 5
let maxnumberPopularToShow: Int = 2

struct Limit {
    static let minProductPrice: Int = 10000
    static let minDeliveryMoney: Int = 10000
    static let maxDeliveryMoney: Int = 20000000
}

struct LengthTf {
    static let maxName: Int = 50
    static let maxProductEachSize: Int = 6
    static let maxQuantity: Int = 3
    static let maxPrice: Int = 15
    static let maxNote: Int = 1000
    static let maxPhoneNumber: Int = 15
    static let maxVoucher: Int = 15
    static let maxAddress: Int = 150
    static let maxProductName: Int = 50
    static let maxChatMsg: Int = 160
}

struct LibKey {
    static let googleMap = "AIzaSyAYNYZukRL8fAPVilmzgpW_uB5ECPheoMc"
    static let googlePlace = "AIzaSyBV-fgXpH8rJTvqCHHMs7HZJQQb8kYLXE0"
    static let walletAppKey = "5aed08c868fc212e22f73836"
}

struct SpecialString {
    static let connectNameAndPhone = " • "
}

// MARK: - Constants API

struct K {
    static let baseURL = "https://api.viettelpost.vn" // "https://api1.viettelpost.vn:8443" //"http://171.244.50.223:8443"//
    static let baseOTTUrl = "https://io.viettelpost.vn/notification/v1.0"
    static let baseURLRegisterDevice = "https://io.viettelpost.vn/notification/v1.0"
    static let baseURLLuckyGame = "https://luckygame.oc.viettelpost.vn/luckygame/v1.0/luckygame"
    static let baseURLHistoryShake = "https://luckygame.oc.viettelpost.vn/luckygame/v1.0/history"
    static let webSocket = "ws://125.212.238.132:8888"
    static let baseWalletUrl = "https://w.viettelpost.vn:9082/v1.0"
    static let baseLocationSuggest = "https://io.viettelpost.vn/location/v1.0"
    static let baseOrderSuggest = "https://io.oc.viettelpost.vn/order/v1.0"
    static let baseUserActiviti = "https://io.viettelpost.vn/activity/v1.0"
    static let baseUrlPrintCustomer = "http://app-digitalize.oc.viettelpost.vn/CustomerPrint/"
    static let baseUrlCapcha = "http://login3g.viettelpost.vn/"
    
    struct Path {
        static let listSender = "/receiver/senders"
        static let listCustomer = "/sender/receivers"
        static let orderReceiver = "/receiver/orders"
        static let senderSuggest = "/sender/_suggest"
        static let listOrder = "/api/setting/listOrder"
        static let listOrderDetail = "/api/setting/getOrderDetail"
        static let listOrderDetailV2 = "/api/setting/getOrderDetailV2"
        static let orderDetailReceiver = "/api/setting/getOrderReceive"
        static let orderDetailReceiverV2 = "/api/setting/getOrderReceiveV2"
        static let listOrderTracking = "/api/setting/listOrderTrackingVTP"
        static let listInventories = "/api/setting/listInventory"
        static let updateOrder = "/api/tmdt/UpdateOrder"
        static let editOrder = "/api/tmdt/EditOrder"
        static let filterOrder = "/api/setting/listOrderFilter"
        static let filterOrderV3 = "/api/setting/listOrderFilterV3"
        static let listAmountOfOrder = "/api/setting/listAmountOfOrder"
        static let listAmountOfOrderV2 = "/api/setting/listAmountOfOrderV2"
        static let listAmountOfOrderV3 = "/api/setting/listAmountOfOrderV3"
        static let discountDeliveryFee = "/api/setting/listCategories"
        static let getOrderRateInfo = "/rate"
        static let orderTemplates = "/api/setting/getOrderTemplate"
        
        static let listService = "/api/setting/listService"
        static let listServiceExtra = "/api/setting/listServiceExtra"
        static let estimateExpressPrice = "/api/tmdt/getPrice"
        static let getListSuggessService = "/api/tmdt/getPriceAll"
        static let getPriceNew = "/api/tmdt/getPriceAllNew"
        static let getListExtraServiceFollowMainService = "/api/setting/listServiceExtraFollowPrivate"
        static let saveOrder = "/api/orders/saveOrderDraft"
        static let insertOrder = "/api/tmdt/InsertOrder"
        static let createFastOrder = "/api/orders/CreateDeliveryOrder"
        static let listAllWards = "/api/setting/listallwards"
        static let listAllProvince = "/api/setting/listallprovince"
        static let listAllDistrict = "/api/setting/listalldistrict"
        static let createUpdateInventory = "/api/setting/CreateUpdateInventoryNew"
        static let insertRateOrder = "/api/setting/insertRateOrder"
        
        //logo
        static let uploadLogo = "/api/user/saveLogoCompany"
        static let getLogo = "/api/user/getLogoCompany"
        static let deleteLogo = "/api/user/deleteLogoCompany"
        
        
        // Location
        static let addressFromLocation = "/address_at"
        static let addressSuggest = "/suggest"
        // SuggestOrder
        static let recentOrder = "/orders/recent"
        static let mostOrder = "/orders/most"
        static let userActivity = "/activity"
        // SuggestProduct
        static let productSuggest = "/product/_suggest"
        // SuggestReceiver
        static let receiverSuggest = "/receiver/_suggest"
        
        // Notification
        static let listTopic = "/topic"
        static let listPublic = "/public"
        static let listNotification = "/notification"
        static let seenTopic = "/topic/seen"
        static let seenPunlic = "/public/seen"
        
        // Chat
        static let insertDevice = "/api/notification/insertDevice"
        static let registerDevice = "/device"
        static let ottChannel = "/channels"
        static let ottMessages = "/topic"
        static let transporterInfo = "/api/setting/getOrderEmployee"
        static let getInfoAuthChannel = "/connect"
        static let ottRateMessage = "/topic"
        
        // Wallet
        static let walletCheckAccValidate = "/core/validate"
        static let walletLogin = "/core/login"
        static let walletBalance = "/core/getUserBalance"
        static let walletDetectPhoneNum = "/core/detect"
        static let walletSendMoney = "/wallet/vtptransfer"
        static let walletUpdatePass = "/core/updatePassword"
        
        // Summary
        static let summaryDashboard = "/api/finance/listOrderSummaryAll"
        static let summaryDashboardV3 = "/api/finance/listOrderSummaryAllV3"
        static let summaryListDidPay = "/api/finance/listPaid"
        static let summaryListBillDidPay = "/api/finance/listBillPaid"
        static let summaryListWaittingPay = "/api/finance/listWaitPaid"
        static let summaryListBillWaittingPay = "/api/finance/listBillWaitPaid"
        static let summaryListNotPay = "/api/finance/listNotPaid"
        static let summaryListBillNotPay = "/api/finance/listBillNotPaid"
        static let summaryGetTotal = "/api/moneyoverview/getTotal"
        
        // StaffRequest and Confirm
        static let staffRequest = "/api/setting/listStaffRequest"
        static let staffConfirm = "/api/setting/doAcceptRequest"
        
        // Setting
        static let checkHavePass = "/api/setting/checkHavePass"
        static let getAppCreateOrderSettings = "/api/user/getAppCreateOrderSettings"
        static let saveAppCreateOrderSettings = "/api/user/saveAppCreateOrderSettings"
        
        // MARK: - viettelpost API analytic.
        
        static let sendAnalyticAPI = "/affiliate/update"
        
        // MARK: - Login FBGG
        
        static let loginFBGG = "/api/user/LoginFBGG"
        
        // MARK: - Promotions
        
        static let promotions = "/api/tmdt/listPromotions/1"
        
        static let updateAvatar = "/api/user/saveAvatar"
        static let getAvatar = "/api/user/avatar"
        
        static let getInvitePhone = "/api/setting/getUserInfo"
        static let getCountAllInvite = "/api/setting/countRefererAll"
        static let getCountMonthInvite = "/api/setting/countReferer"
        
        static let generatePrintURL = "/api/setting/encryptLinkPrintV2"
        static let sendMedia = "/media/v1.0/media"
        
        static let shareOrderRoute = "/api/orders/sharing"
        static let getOrderRoute = "/api/orders/detailV2"
        
        static let ssoUpdater = "/api/user/ssoUpdateUser"
    }
    
    // MARK: API parameter key
    
    // * Get list order, order detail, update Order
    static let type = "TYPE"
    static let orderStatus = "STATUS"
    static let inventory = "INVENTORY"
    static let dateFrom = "DATE_FROM"
    static let dateTo = "DATE_TO"
    static let orderNumberDetail = "OrderNumber"
    static let note = "NOTE"
    static let date = "DATE"
    static let otherProperty = "OTHER_PROPERTIES"
    
    // * Insert, save order
    static let orderNumber = "ORDER_NUMBER"
    static let orderReference = "ORDER_REFERENCE"
    static let warehouseId = "GROUPADDRESS_ID"
    static let customerId = "CUS_ID"
    static let deliveryDate = "DELIVERY_DATE"
    static let senderFullName = "SENDER_FULLNAME"
    static let senderAddress = "SENDER_ADDRESS"
    static let senderPhone = "SENDER_PHONE"
    static let senderEmail = "SENDER_EMAIL"
    static let senderWardId = "SENDER_WARD"
    static let senderDistrictId = "SENDER_DISTRICT"
    static let senderProvinceId = "SENDER_PROVINCE"
    static let senderLat = "SENDER_LATITUDE"
    static let senderLong = "SENDER_LONGITUDE"
    static let receiverFullName = "RECEIVER_FULLNAME"
    static let receiverAddress = "RECEIVER_ADDRESS"
    static let receiverPhone = "RECEIVER_PHONE"
    static let receiverEmail = "RECEIVER_EMAIL"
    static let receiverWardId = "RECEIVER_WARD"
    static let receiverDisId = "RECEIVER_DISTRICT"
    static let receiverProvinceId = "RECEIVER_PROVINCE"
    static let receiverLat = "RECEIVER_LATITUDE"
    static let receiverLong = "RECEIVER_LONGITUDE"
    static let productName = "PRODUCT_NAME"
    static let productDescription = "PRODUCT_DESCRIPTION"
    static let productQuantity = "PRODUCT_QUANTITY"
    static let productPrice = "PRODUCT_PRICE"
    static let productWeight = "PRODUCT_WEIGHT"
    static let productLength = "PRODUCT_LENGTH"
    static let productWidth = "PRODUCT_WIDTH"
    static let productHeight = "PRODUCT_HEIGHT"
    static let productType = "PRODUCT_TYPE"
    static let orderPayment = "ORDER_PAYMENT"
    static let orderMainService = "ORDER_SERVICE"
    static let orderOptionsService = "ORDER_SERVICE_ADD"
    static let orderVoucher = "ORDER_VOUCHER"
    static let orderNote = "ORDER_NOTE"
    static let moneyCollection = "MONEY_COLLECTION"
    static let moneyTotalFee = "MONEY_TOTALFEE"
    static let moneyFeeCOD = "MONEY_FEECOD"
    static let moneyFeeVAS = "MONEY_FEEVAS"
    static let moneyFeeInsurrance = "MONEY_FEEINSURRANCE"
    static let moneyFee = "MONEY_FEE"
    static let moneyFeeOther = "MONEY_FEEOTHER"
    static let moneyTotalVAT = "MONEY_TOTALVAT"
    static let moneyTotal = "MONEY_TOTAL"
    static let orderType = "ORDER_TYPE"
    // - Estimate price
    static let nationalType = "NATIONAL_TYPE"
    // - Get list Main service
    static let serviceType = "TYPE"
    // - Add Warehouse
    static let inventoryId = "INVENTORY_ID"
    static let postId = "POST_ID"
    static let name = "NAME"
    static let phone = "PHONE"
    static let address = "ADDRESS"
    static let provinceId = "PROVINCE_ID"
    static let distId = "DISTRICT_ID"
    static let wardId = "WARDS_ID"
    // - Login
    static let userName = "USERNAME"
    static let password = "PASSWORD"
    static let source = "SOURCE"
    static let rate = "RATE"
    static let start = "START"
    static let end = "END"
    static let order505 = "ORDER505"
    
    static let filter = "filter"
    static let ofs = "ofs"
    static let size = "size"
    static let status = "status"
    
    static let fromDate = "fromDate"
    static let toDate = "toDate"
    static let q = "q"
    // - Setting
    static let pID = "pID"
    
    static let isSendProductAtPost = "IS_BUUCUC"
    static let is_cod_auto = "IS_COD_AUTO"
}

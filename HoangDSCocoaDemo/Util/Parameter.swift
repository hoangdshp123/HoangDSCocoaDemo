//
//  Parameter.swift
//  MyViettelPost
//
//  Created by Vu Van Tiep on 4/9/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import Foundation

// User
let kUSERNAME = "USERNAME"
let kOTP = "OTP"
let kACCESS_TOKEN = "ACCESS_TOKEN"

// ConfigAPIs
let kPASSWORD_OLD = "PASSWORD_OLD"
let kPASSWORD_NEW = "PASSWORD_NEW"
let pPWD = "pPWD"
let pID = "pID"
let kBANKID = "BANKID"
let kBRANCH = "BRANCH"
let kREPRESENT = "REPRESENT"
let kBANKNUMBER = "BANKNUMBER"
let kCUS_ID = "CUS_ID"
let kPAYMENT = "PAYMENT"
let kPAYTYPE = "PAYTYPE"
let kPASSWORD = "PASSWORD"
let kEMAIL = "EMAIL"
let kDISPLAYNAME = "DISPLAYNAME"
let kFIRSTNAME = "FIRSTNAME"
let kLASTNAME = "LASTNAME"
let kACTION = "ACTION"
//Update new pass
let kPhone = "Phone"    
let kTypeAccount = "Type"
let kNewPass = "NewPass"
let kAccessTokenAccountKit = "AccessToken"
let kEmail = "Email"
let kOTPEmail = "OtpEmail"
let kCapcha = "Captcha"

// Acount
let kFIRST_NAME = "FIRST_NAME"
let kLAST_NAME = "LAST_NAME"
let kBIRTHDATE = "BIRTHDATE"
let kPASSPORTNUMBER = "PASSPORTNUMBER"

// InventoryAPIs
let kINVENTORY_ID = "INVENTORY_ID"
let kPOST_ID = "POST_ID"
let kNAME = "NAME"
let kPHONE = "PHONE"
let kADDRESS = "ADDRESS"
let kPROVINCE_ID = "PROVINCE_ID"
let kDISTRICT_ID = "DISTRICT_ID"
let kWARDS_ID = "WARDS_ID"

// ComplainAPIs
let pRateGroup = "pRateGroup"
let kORDER_NUMBER = "ORDER_NUMBER"
let kCONTENT = "CONTENT"
let kTYPE = "TYPE"

// EvaluateAPIs
let kGROUPADDRESS_ID = "GROUPADDRESS_ID"
let pGROUP = "pGROUP"
let pQUEST = "pQUEST"
let pRATE = "pRATE"
let pNOTE = "pNOTE"

// Billing
let pLOAIXE = "pLOAIXE"
let pTINHDI = "pTINHDI"
let pTINHDEN = "pTINHDEN"
let PDIEMDUNG = "PDIEMDUNG"
let pGIAXECAU = "pGIAXECAU"
let pLUUDEM = "pLUUDEM"
let pSOKM = "pSOKM"

// Setting
let kchat = "chat"
let knews = "news"
let ksuccessOrder = "successOrder"
let kreturnOrder = "returnOrder"

// MARK: - Title Button
let bHangHoaKhongHoTro = "Danh mục hàng hoá không hỗ trợ"
let bHangHoaCamBay = "Danh mục hàng hoá cấm bay"
let bHangHoaDongGoi = "Quy định đóng gói hàng hoá"

// MARK: - Condition Content
let cHangHoaKhongHoTro = "1.    Các chất ma túy và chất kích thích thần kinh.\n2.   Vũ khí đạn dược, trang thiết bị kỹ thuật quân sự, hiện vật thuộc di tích văn hóa lịch sử.\n3.   Các loại văn hóa phẩm đồi trụy, phản động, ấn phẩm tài liệu nhằm phá hoại trật tự công cộng chống lại Nhà nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.\n4.  Vật hoặc chất dễ nổ, dễ cháy và các chất gây nguy hiểm hoặc làm mất vệ sinh, gây ô nhiễm môi trường.\n5.    Các loại vật phẩm hàng hóa mà Nhà nước cấm lưu thông, cấm kinh doanh, cấm xuất nhập khẩu.\n6.   Vật phẩm, ấn phẩm, hàng hóa cấm nhập vào nước nhận theo thông báo của Liên minh Bưu chính Thế giới (UPU).\n7.  Thư trong bưu kiện ( thư gửi kèm trong hàng hóa).\n8.  Vật phẩm, hàng hóa trong thư, ấn phẩm, học phẩm dùng cho người mù (NĐ 142/2004/NĐ-CP ngày 08/07/2014).\n9.  Bưu gửi chưa nhiều bưu gửi, gửi cho nhiều địa chỉ nhận khác nhau.\n10. Sinh vật sống.\n11. Tiền Việt Nam, tiền nước ngoài và các giấy tờ có giá trị như tiền.\n12. Các loại kim khí quý (vàng, bạc, bạch kim…), các loại đá quý hay các sản phẩm khác được chế biến từ kim khí quý, đá quý.\nLưu ý: Viettel Post không hỗ trợ giao những hàng hóa nằm trong danh mục hàng hóa cấm vận chuyển, nếu quý khách cố ý gửi các hàng hóa trên, Viettel Post sẽ không chịu trách nhiệm nếu xảy ra hư hỏng, thất lạc hoặc bị pháp luật truy cứu."

let cHangHoaCamBay = "Hàng nguy hiểm được phân thành 9 nhóm theo các loại nguy hiểm sau:\nNhóm 1: Các loại chất nổ như chất nổ, vật liệu nổ, pháo hoa, đạn,…\nNhóm 2: Chất khí như các chất khí dễ cháy, các loại khí độc, các loại khí không dễ cháy, không độc, …\nNhóm 3: Chất lỏng dễ cháy như sơn, xăng, chất lỏng dễ cháy.\nNhóm 4: Chất rắn dễ cháy.\nNhóm 5 Các chất oxy hóa, hợp chất hữu cơ.\nNhóm 6 Các chất độc hại, chất lây nhiễm.\nNhóm 7 Các loại nguyên liệu chất phóng xạ, chất phóng xạ.\nNhóm 8 Các chất hóa học gây nguy hiểm khi tiếp xúc.\nNhóm 9 Các loại hàng nguy hiểm khác như chất gây mê, kích thích, chất từ tính, vật phẩm.\nLưu ý: Qúy khách khai đúng thông tin hàng hóa để Viettel Post phân loại và có hình thức vận chuyển hợp lý (Đường bay, đường bộ), nếu không hàng hóa có thể bị thu giữ tại cơ quan an ninh hàng không hoặc bị phạt vì cố tình vận chuyển hàng cấm bay."

let cHangHoaDongGoi = "Viettel Post chỉ nhận hàng hóa đã được đóng gói, bảo quản đúng quy chuẩn và giao hàng nguyên đai nguyên kiện, không đồng kiểm hàng hóa.\nViệc đóng gói chỉ đạt tiêu chuẩn khi đảm bảo các yêu cầu sau:\nHàng hóa không bị di chuyển, xộc xệch dưới tác dụng của ngoại lực.\nGói kính bằng bang keo, đảm bảo không rơi sản phẩm ra khỏi bao bì trong quá trình vận chuyển, không dùng dây thường, dây vải.\nCác hàng hóa đặc biệt như chất lỏng, hàng dễ vỡ, hàng dễ móp méo, dễ nóng chảy phải được đóng gói để đáp ứng được với điều kiện vận chuyển.\nKhông nên sử dụng giấy, vải để đóng gói. Với các mặt hàng dễ bị bẩn ướt, cần đặt vào túi nylon dán kín bằng băng dính trước khi đóng gói.\nHóa đơn hay tài liệu hướng dẫn sử dụng cần để trong thùng hàng trước khi đóng gói, không dán bên ngoài thùng."

// MARK: - Content
// 1
let kHangHoaKhongHoTro = "•   Viettel Post không hỗ trợ giao nhận các mặt hàng cấm theo quy định của nhà nước như ma túy, chất kích thích thần kinh, vũ khí đạn dược, trang thiết bị kỹ thuật quân sự và một số mặt hàng đặc thù: thực phẩm tươi sống, sinh vật sống,…\n•   Viettel Post không chịu trách nhiệm nếu bạn cố ý gửi những mặt hàng này."

let kHangHoaCamBay = "•   Theo quy định hàng không, một số hàng hóa dạng lỏng, nén khí, dễ cháy nổ, có nguy cơ phóng xạ thuộc hàng cấm bay. Với hàng hóa cấm bay Viettel Post hỗ trợ giao bằng đường bộ, lâu hơn khoảng 3-5 ngày."

let kHangHoaDongGoi = "•   Viettel Post chỉ nhận hàng hóa đã được đóng gói, bảo quản đúng quy chuẩn, giao hàng nguyên đai nguyên kiện, không đồng kiểm hàng hóa.\n•   Quy định đóng gói được sử dụng làm căn cứ quy chiếu trách nhiệm cho các bên liên quan khi xảy ra khiếu nại do lỗi phát sinh trong quá trình vận chuyển."

let kQuyDinhHangHoa = "•   Hàng hóa (không phải đồ cá nhân) cần có giấy tờ chứng minh nguồn gốc, xuất xứ hoặc hóa đơn GTGT đi kèm.\n•   Viettel Post không chịu trách nhiệm trong trường hợp hàng hóa bị Quản lý thị trường và các cơ quan chức năng thu giữ theo quy định của pháp luật."

let kChuyenHoan = "•   Viettel Post sẽ chuyển hoàn hàng hóa về địa chỉ người gửi hoặc điểm giao dịch gần nhất trong các trường hợp người nhận từ chối nhận hàng, hoặc không phát được.\n•   Viettel Post phát bưu gửi tối đa 3 lần. Khi hàng chuyển hoàn về, người gửi phải chịu 50% cước chính."

// 2
let kTaoDon = "•   Đối với quý khách lần đầu sử dụng ứng dụng, quý khách vui lòng chọn chức năng “Siêu tốc”, chọn địa chỉ gửi hàng và tạo yêu cầu gửi hàng từ ứng dụng. Sau đó, nhân viên của Viettel Post sẽ liên hệ, gặp và tư vấn, hướng dẫn quý khách sử dụng dịch vụ của Viettel Post.\n•   Đối với quý khách đã sử dụng ứng dụng để tạo đơn, quý khách có thêm các tiện ích mới để tạo đơn nhanh chóng dễ dàng nhất như tạo đơn từ gợi ý người nhận, gợi ý địa chỉ, tạo đơn từ bản sao các vận đơn đã tạo trước đó và rất nhiều hỗ trợ thông minh khác. "

let kLayHang = "•   Đóng gói hàng hóa theo tiêu chuẩn Viettel Post quy định\n•   In và dánh phiếu gửi lên bưu kiện hoặc mã vận đơn lên kiện hàng (đối với bưu tá)\n•   Tiếp nhận và kiểm tra nội dung hàng hóa.\n•   Cập nhật trạng thái lấy hàng.\n•   Thời gian lấy hàng quy định như sau\n•   Đơn tạo trước 16h thì nhận hàng trong ngày.\n•   Đơn tạo sau 16h thì nhận hàng vào sáng ngày hôm sau."

let kGiaoHang = "•   Viettel Post luôn hỗ trợ giao hàng tốt nhất, nếu quý khách có việc bận tại thời điểm giao hàng, bưu tá sẽ lưu ý và giao lại vào ca sau hoặc ngày mà khách hàng hẹn.\n•   Viettel Post luôn cố gắng giao lại, hỗ trợ quý khách để giao hàng thành công. Tuy nhiên đối với các vận đơn bị người nhận trễ hẹn quá 3 lần, Viettel Post sẽ chuyển trạng thái vận đơn thành Không giao được hàng, tiến hành hoàn hàng để trả lại hàng cho quý khách."

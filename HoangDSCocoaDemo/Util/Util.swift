//
//  Util.swift
//  MyViettelPost
//
//  Created by Pham Diep on 3/21/18.
//  Copyright © 2018 PPCLink. All rights reserved.
//

import CoreLocation
import UIKit
import SwiftyJSON

class Util: NSObject {
    class func initVC(atStoryboard: String, vcId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: atStoryboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vcId)
    }
    
    class func genGradientImg(fromCALayer caLayer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContext(caLayer.frame.size)
        caLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImg
    }
    
    class func makeSearchString(input: String) -> String {
        let lowercaseStr = input.lowercased()
        let uppercaseStr = input.uppercased()
        
        let stringInputArr = input.components(separatedBy: " ")
        var firstCharacters = ""
        for string in stringInputArr {
            if string.count > 0 {
                firstCharacters += String(string.first!)
            }
        }
        
        let dictReplace: Dictionary = ["a": "[áàảãạăắặằẳẵâấầẩẫậ]",
                                       "d": "đ",
                                       "e": "[éèẻẽẹêếềểễệ]",
                                       "i": "[íìỉĩị]",
                                       "o": "[óòỏõọôốồổỗộơớờởỡợ]",
                                       "u": "[úùủũụưứừửữự]",
                                       "y": "[ýỳỷỹỵ]"]
        var stripedUnicode = input.lowercased()
        for key in dictReplace.keys {
            stripedUnicode = stripedUnicode.replacingOccurrences(of: dictReplace[key]!, with: key, options: .regularExpression, range: nil)
        }
        
        return input + "," +
            stripedUnicode.capitalized + "," +
            lowercaseStr + "," +
            uppercaseStr + "," +
            firstCharacters.lowercased() + "," +
            firstCharacters.uppercased() + "," +
            stripedUnicode + "," +
            stripedUnicode.uppercased()
    }
    
    class func checkGpsIsOn() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    class func rootAppVC() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    
    class func locationValidate(lat: Double, lng: Double) -> Bool {
        if lng < 102 || lng > 110 ||
            lat < 5 || lat > 22 {
            return false
        } else {
            return true
        }
    }
    
    class func getUserAgent() -> String {
        return "iOS/\(UIDevice.current.systemVersion)"
    }
    
    class func dateTrackingToStringShow(timeStamp: Double) -> String {
        let timeAmount = Date().timeIntervalSince1970 - timeStamp / 1000
        if timeAmount <= 60 * 60 {
            return "Đang hoạt động"
        }
        let dateFromTimeStamp = Date(timeIntervalSince1970: timeStamp / 1000)
        if timeAmount <= 84600 {
            return "\(Int(timeAmount / 3600)) giờ trước"
        }
        return dateFromTimeStamp.toString(format: "dd/MM/yyyy")
    }
    
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }

}

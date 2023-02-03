//
//  Const.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/21.
//

import Foundation
import QMUIKit
import SnapKit
import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScreenScale: CGFloat = UIScreen.main.scale
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/// 是否全面屏设备
let IS_NOTCHED_SCREEN = QMUIHelper.isNotchedScreen
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
let kThemeColor = UIColor(hexString: "#0A75D8")

// UserDefault
let kUserInfo = "userInfo"
let kCustomerInfo = "customerInfo"
let kU3dData = "u3dData"
var kCostomerPhone: String? {
    let dic = UserDefaults.standard.dictionary(forKey: kCustomerInfo) as? [String: String]
    return dic?["userPhone"]
}

var kCostomerId: String? {
    let dic = UserDefaults.standard.dictionary(forKey: kCustomerInfo) as? [String: String]
    return dic?["userId"]
}

// Path
let kFaceModelsPath = "FaceModel"

var kUserDirectory: String {
    let dic = UserDefaults.standard.dictionary(forKey: kCustomerInfo) as? [String: String]
    let phone = dic?["userPhone"] ?? "Temporary"
    let path = "\(kFaceModelsPath)/\(phone)"
    return path
}

let kSCNNodeFile = "data.scnnode"

var copyrightStr: String {
    let year = DateUtil.currentDate().year ?? 2022
    return "Copyright © \(year) Kangzao. All Rights Reserved"
}

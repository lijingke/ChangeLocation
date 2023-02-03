//
//  EncryptUtil.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/9/16.
//

import Foundation
import UIKit

// class EncryptUtil {
//    static let enKey = ""
//    static let enIv = ""
//    /// 是否开启加密模式
//    static let openEncrypt = false
//    /// 解密字符串
//    static func decrypt(_ str: String) -> String {
//        do {
//            let aes = try AES(key: enKey, iv: enIv)
//            let data = try aes.decrypt(str.bytes)
//            let value = String(data: Data(data), encoding: .utf8)!
//            return value
//        } catch {
//            LogUtil.log("。。。。解密出错了。。。。。")
//        }
//        return ""
//    }
//
//    /// AES加密该字符串
//    static func encrypt(_  str: String) -> String {
//        do {
//            let aes = try AES(key: enKey, iv: enIv)
//            let encrypted = try aes.encrypt(str.bytes)
//            return encrypted.toBase64()
//        } catch {
//            LogUtil.log("。。。。加密出错了。。。。。")
//        }
//        return ""
//    }
//
//    /// 加密该字典
//    static func encrypt(_ dic: [String: Any]) -> String {
//        let data: Data! = try? JSONSerialization.data(withJSONObject: dic, options: [])
//        let str = String(data: data, encoding: .utf8)!
//        return self.encrypt(str)
//    }
// }

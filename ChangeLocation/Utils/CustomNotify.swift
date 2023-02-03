//
//  CustomNotify.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import Foundation

enum CustomNotify {
    // 全局临时变量
    static var overallTempVar: [String: Any]?

    // 微信登录通知
    static var wechatLoginNotify: String {
        return "wechatLoginNotify"
    }

    // 微信支付状态通知
    static var wechatPayNotify: String {
        return "wechatPayNotify"
    }

    // 支付宝支付状态通知
    static var alipayNotify: String {
        return "alipayNotify"
    }
}

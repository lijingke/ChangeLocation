//
//  UIFont+Extension.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import UIKit

public extension UIFont {
    static func medium(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "PingFangSC-Medium", size: fontSize)
    }

    static func regular(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "PingFangSC-Regular", size: fontSize)
    }

    static func DINBold(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "DINAlternate-Bold", size: fontSize)
    }

    static func semibold(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "PingFangSC-Semibold", size: fontSize)
    }

    static func light(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "PingFangSC-Light", size: fontSize)
    }

    static func bold(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Helvetica-Bold", size: fontSize)
    }
}

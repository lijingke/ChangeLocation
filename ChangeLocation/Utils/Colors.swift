//
//  Colors.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import Foundation
import UIKit

enum Colors {
    /// 随机色
    static var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    // 标题颜色
    static var titleColor: UIColor {
        return UIColor(hexString: "#333333")
    }
}

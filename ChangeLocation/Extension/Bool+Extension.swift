//
//  Bool+Extension.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import Foundation

public extension Bool {
    var toInt: Int { return self ? 1 : 0 }

    @discardableResult
    mutating func toggled() -> Bool {
        self = !self
        return self
    }
}

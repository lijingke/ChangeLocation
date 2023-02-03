//
//  ViewStyle.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import UIKit

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {
    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }
}

func style<T>(_ object: T, with style: ViewStyle<T>) {
    style.style(object)
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }

    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}

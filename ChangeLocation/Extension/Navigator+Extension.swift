//
//  Navigator.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/22.
//

import Foundation
import URLNavigator

extension Navigator {
    func pop(animated: Bool = true) {
        UIViewController.topMost?.navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)?) {
        UIViewController.topMost?.navigationController?.dismiss(animated: animated, completion: completion)
    }

    func pop(toVC classStr: String?, withAnimate animate: Bool = true) {
        let navigationController = UIViewController.topMost?.navigationController
        var destinationController: UIViewController?
        for subController in navigationController?.viewControllers ?? [] {
            if isController(subController, contain: classStr) {
                destinationController = subController
                break
            }
        }
        if let destinationController = destinationController {
            navigationController?.popToViewController(destinationController, animated: animate)
        }
    }

    func isController(_ controller: UIViewController, contain classString: String?) -> Bool {
        let controllerClass = NSStringFromClass(type(of: controller).self)
        if controllerClass.contains(find: classString ?? "") {
            return true
        }
        let subControllers = controller.children
        var isContain = false
        for subController in subControllers {
            if isController(subController, contain: classString) == true {
                isContain = true
            }
        }
        return isContain
    }
}

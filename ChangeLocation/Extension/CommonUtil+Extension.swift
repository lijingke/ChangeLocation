//
//  CommonUtil+Extension.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/9/29.
//

import Foundation
import UIKit

extension CommonUtil {
    static func upload(_: UIImage) {}

    static func getAllFilePath(_ dirPath: String) -> [String]? {
        var filePaths = [String]()

        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: dirPath)

            for fileName in array {
                var isDir: ObjCBool = true

                let fullPath = "\(dirPath)/\(fileName)"

                if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if !isDir.boolValue {
                        filePaths.append(fullPath)
                    }
                }
            }

        } catch let error as NSError {
            LogUtil.log("get file path error: \(error)")
        }

        return filePaths
    }
}

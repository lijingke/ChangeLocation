//
//  PermissionUtil.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/12/10.
//

import Foundation
import Permission

class PermissionUtil: NSObject {
    static let sharedInstance = PermissionUtil()

    private lazy var cameraPermission: Permission = {
        let permission = Permission.camera
        let alert = permission.prePermissionAlert
        alert.title = "请授权相机访问权限"
        alert.message = "太合睛需要请求相机访问权限来用于扫描建模"
        alert.cancel = "暂不"
        alert.confirm = "授权"

        let deniedAlert = permission.deniedAlert // or permission.disabledAlert
        deniedAlert.title = "请允许获取相机访问权限"
        deniedAlert.message = nil
        deniedAlert.cancel = "取消"
        deniedAlert.settings = "设置"
        return permission
    }()

    private lazy var photoPermission: Permission = {
        let permission = Permission.photos
        let alert = permission.prePermissionAlert
        alert.title = "请授权相册访问权限"
        alert.message = "太合睛需要请求相册访问权限来用于签名保存"
        alert.cancel = "暂不"
        alert.confirm = "授权"

        let deniedAlert = permission.deniedAlert // or permission.disabledAlert
        deniedAlert.title = "请允许获取相册访问权限"
        deniedAlert.message = nil
        deniedAlert.cancel = "取消"
        deniedAlert.settings = "设置"
        return permission
    }()

    public func requestCameraPermission() {
        cameraPermission.request { _ in
        }
    }

    public func requestPhotosPermission() {
        photoPermission.request { _ in
        }
    }
}

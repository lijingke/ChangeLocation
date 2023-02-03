//
//  JKTimer.swift
//  PlayGround
//
//  Created by 李京珂 on 2021/8/24.
//

import Foundation

class JKTimer: NSObject {
    private(set) var _timer: Timer!
    fileprivate weak var _aTarget: AnyObject!
    fileprivate var _aSelector: Selector!
    var fireDate: Date {
        get {
            return _timer.fireDate
        }
        set {
            _timer.fireDate = newValue
        }
    }

    class func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: AnyObject, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> JKTimer {
        let timer = JKTimer()

        timer._aTarget = aTarget
        timer._aSelector = aSelector
        timer._timer = Timer.scheduledTimer(timeInterval: ti, target: timer, selector: #selector(JKTimer.jk_timerRun), userInfo: userInfo, repeats: yesOrNo)
        return timer
    }

    func fire() {
        _timer.fire()
    }

    func pause() {
        _timer.fireDate = Date.distantFuture
    }

    func reactivate() {
        _timer.fireDate = Date.distantPast
    }

    func invalidate() {
        _timer.invalidate()
    }

    @objc func jk_timerRun() {
        // 如果崩在这里，说明你没有在使用Timer的VC里面的deinit方法里调用invalidate()方法
        _ = _aTarget.perform(_aSelector)
    }

    deinit {
        LogUtil.log("计时器已销毁")
    }
}

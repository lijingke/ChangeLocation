//
//  CountDownTimer.swift
//  PlayGround
//
//  Created by 李京珂 on 2021/8/24.
//

import Foundation

class CountDownTimer {
    /// 结束秒数
    var secondsToEnd: Int = 0
    var myTimer: JKTimer!
    var callBack: ((Int) -> Void)?

    init(seconds: Int, callBack: ((Int) -> Void)?) {
        secondsToEnd = seconds
        myTimer = JKTimer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        // 如果希望对Timer做自定义的操作，使用_Timer属性
        RunLoop.current.add(myTimer._timer, forMode: RunLoop.Mode.common)
        myTimer.fire()
        self.callBack = callBack
    }

    deinit {
        myTimer.invalidate()
    }

    @objc func timerRun() {
        secondsToEnd -= 1
        if secondsToEnd == 0 {
            myTimer.invalidate()
        }
        callBack?(secondsToEnd)
    }

    func pause() {
        myTimer.pause()
    }

    func reactivate() {
        myTimer.reactivate()
    }

    func destory() {
        myTimer.invalidate()
    }
}

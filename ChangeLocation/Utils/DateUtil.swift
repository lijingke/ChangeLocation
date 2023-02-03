//
//  DateUtil.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/8/25.
//

import Foundation

class DateUtil: NSObject {
    /// 返回当前系统时间戳
    /// - Returns: 返回的秒级时间戳
    static func getCurrentTimeStamp() -> Int {
        let nowDate = Date()

        // 10位数时间戳

        let interval = Int(nowDate.timeIntervalSince1970)

        // 13位数时间戳 (13位数的情况比较少见)

        // let interval = CLongLong(round(nowDate.timeIntervalSince1970*1000))

        return interval
    }

    /// 获取当前日期
    @objc static func currentDate(format: String) -> String {
        return formatter(date: Date(), format: format)
    }

    /// 获取当前星期几，周一就是1，周日就是7
    static func getWeak() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let comps: DateComponents = calendar.dateComponents([.weekday], from: Date())
        let weak = comps.weekday! - 1
        return weak
    }

    /// 根据一个日期获取星期几
    static func getWeak(date: Date) -> (weak: Int, weakStr: String) {
        let calendar = Calendar(identifier: .gregorian)
        let comps: DateComponents = calendar.dateComponents([.weekday], from: date)

        var weak = comps.weekday! - 1
        if weak == 0 { // 星期0 =  星期7 = 星期天
            weak = 7
        }
        var weakStr = ""
        switch weak {
        case 1:
            weakStr = "周一"
        case 2:
            weakStr = "周二"
        case 3:
            weakStr = "周三"
        case 4:
            weakStr = "周四"
        case 5:
            weakStr = "周五"
        case 6:
            weakStr = "周六"
        case 7:
            weakStr = "周日"
        default:
            break
        }
        return (weak, weakStr)
    }

    /// 获取上个月的yyyy-MM-dd
    static func getLastMonth(num: Int) -> String {
        let curDate = Date()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"

        let calendar = Calendar(identifier: .gregorian)
        var lastMonthComps = DateComponents()
        // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        lastMonthComps.month = num
        let newDate = calendar.date(byAdding: lastMonthComps, to: curDate)
        let dateStr = formater.string(from: newDate!)

        return dateStr
    }

    /// 格式化时间
    @objc static func formatter(date: Date, format: String) -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = format
        let datestr = dformatter.string(from: date)
        return datestr
    }

    /// 获取当前时间的时间戳（去小数点秒）
    static func getTimeInterval() -> Double {
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        /// 去小数点
        let timeStamp = Int(round(timeInterval))
        return Double(timeStamp)
    }

    /// 返回毫秒(获取当前毫秒)
    static func getTimeMillisecondInterval() -> Int {
        let timeInterval = getTimeInterval()
        return Int(timeInterval) * 1000
    }

    /// 根据时间戳，返回对应格式日期（传入秒数，通过timeIntervalSince1970获取的都是秒）
    static func getDateStr(interval: Double, format: String) -> String {
        if interval <= 0 {
            return ""
        }
        let createDate = Date(timeIntervalSince1970: TimeInterval(interval))
        let value = createDate.toString(format)
        return value
    }

    /// 根据时间戳，返回对应格式日期（传入毫秒数）
    @objc static func getDateStr2(interval: Double, format: String) -> String {
        if interval <= 0 { return "" }
        let inter = interval / 1000
        let time = getDateStr(interval: inter, format: format)
        return time
    }

    /// 根据时间戳，返回一分钟前，一小时前
    static func getTimerDesc(interval: Double) -> String {
        let timerInter: Double = interval / 1000
        if timerInter <= 0 {
            return ""
        }
        let current = getTimeInterval()
        if timerInter > current {
            return ""
        }
        let time = current - timerInter
        if time < 60 {
            return "1分钟前"
        } else if time < 60 * 60 {
            return String(format: "%.0f分钟前", time / 60)
        } else if time < 60 * 60 * 24 {
            return String(format: "%.0f小时前", time / 60 / 60)
        } else if time < 60 * 60 * 24 * 24 {
            return String(format: "%.0f天前", time / 60 / 60 / 24)
        }

        return getDateStr(interval: timerInter, format: "yyyy-MM-dd")
    }

    static func getMorningDate(date: Date) -> Date {
        let calendar = NSCalendar(identifier: .chinese)
        let components = calendar?.components([.year, .month, .day], from: date)
        return (calendar?.date(from: components!))!
    }

    /// 返回给定天数后的日期时间
    static func getDelay(since: Date, day: Int) -> Date {
        let inter = Double(day * 24 * 60 * 60)
        let date = Date(timeInterval: inter, since: since)
        return date
    }

    static func nowTimeString() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        // 日期显示格式，可按自己需求显示
        timeFormatter.dateFormat = "yyy-MM-dd' at 'HH:mm:ss"
        let strNowTime = timeFormatter.string(from: date) as String
        return strNowTime
    }

    /// 返回给定分钟数后的日期时间
    static func getDelay(since: Date, minute: Int) -> Date {
        let inter = Double(minute * 60)
        let date = Date(timeInterval: inter, since: since)
        return date
    }

    /// 根据字符串，获取北京时间Date(解决了8小时时间差，已测试)
    static func getDate(_ dateStr: String, _ formatterStr: String? = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        //        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        formatter.dateFormat = formatterStr
        guard let date = formatter.date(from: dateStr) else { return nil }
        return date
    }

    /// 获取当前北京时间（已测试）
    static func curDate() -> Date {
        let date = Date()
        let zone = NSTimeZone.system // 这里必须
        let interval = zone.secondsFromGMT(for: date)
        let curDate = date.addingTimeInterval(TimeInterval(interval))
        return curDate
    }

    static func currentDate() -> DateComponents {
        let date = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(in: TimeZone.current, from: date)
        return dateComponents
    }

    /**
     返回两个时间差秒，返回倒计时格式 HH:mm:ss,
     befor:yyyy-MM-dd HH:mm:ss
     */
    static func getDownTime(_ seconds: Int) -> (h: Int, m: Int, s: Int) {
        if seconds <= 0 { return (0, 0, 0) }
        let hour = Int(seconds / 3600)
        let minute = Int((seconds % 3600) / 60)
        let second = Int(seconds % 60)
        return (h: hour, m: minute, s: second)
    }

    ////获取倒计时差(秒)  时间差  时间比较
    static func getDateBetween(_ beforDate: String, _ endDate: String, format: String) -> Int {
        //        let format = "yyyy-MM-dd HH:mm:ss"
        let befDate = getDate(beforDate, format)
        let endDate = getDate(endDate, format)
        if befDate == nil || endDate == nil { return 0 }
        let cha = endDate!.timeIntervalSince1970 - befDate!.timeIntervalSince1970
        return Int(cha)
    }

    /// 时间比较，是否升序<
    static func compareASC(date1: Date, date2: Date) -> Bool {
        if date1.compare(date2) == .orderedAscending {
            return true
        }
        return false
    }

    /// 时间比较，是否降序<
    static func compareDESC(date1: Date, date2: Date) -> Bool {
        if date1.compare(date2) == .orderedDescending {
            return true
        }
        return false
    }

    // 字符串转时间戳
    static func timeStrChangeTotimeInterval(time: String?, dateFormat: String? = nil) -> Int? {
        guard let timeStr = time else { return nil }
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            format.dateFormat = dateFormat
        }
        if let date = format.date(from: timeStr) {
            return Int(date.timeIntervalSince1970)
        } else {
            return nil
        }
    }
}

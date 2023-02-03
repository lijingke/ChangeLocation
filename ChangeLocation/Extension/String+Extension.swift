//
//  String+Extension.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/7/20.
//

import Foundation
import UIKit

// MARK: 空格处理

extension String {
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace: String {
        let whitespace = NSCharacterSet.whitespaces
        return trimmingCharacters(in: whitespace)
    }

    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro: String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return trimmingCharacters(in: whitespace)
    }

    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }

    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0 ..< num {
            beginSpace += " "
        }
        return beginSpace + removeHeadAndTailSpacePro
    }
}

// MARK: 字符串常规操作

extension String {
    /*
     *字符串替换
     */
    func replaceString(oldString: String, newString: String) -> String {
        return replacingOccurrences(of: oldString, with: newString, options: .literal, range: nil)
    }

    /**  是否包含一个字符串  */
    func contains(find: String) -> Bool {
        return range(of: find) != nil
    }

    /**  判断  */
    func containsIgnoringCase(find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }

    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript(r: Range<Int>) -> String {
        if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
        let startIndex = index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: r.upperBound)
        return String(self[startIndex ..< endIndex])
    }

    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) -> String {
        if !(end < count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[...sInde])
    }

    /// 截取第任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(start: Int) -> String {
        if !(start < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: start)
        // return substring(with: sRang)
        return String(self[sRang...])
    }

    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    func stringInsert(content: String, locat: Int) -> String {
        if !(locat < count) { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(start: locat + 1)
        return str1 + content + str2
    }

    public func removeCharsFromEnd(count_: Int) -> String {
        let stringLength = count
        let substringIndex = (stringLength < count_) ? 0 : stringLength - count_
        let index = self.index(startIndex, offsetBy: substringIndex)
        return String(self[...index])
    }

    public func split(_ separator: String) -> [String] {
        return components(separatedBy: separator).filter {
            !$0.trimmed().isEmpty
        }
    }

    public func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: Range 和 NSRange 之间的转换

extension String {
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    /// NSRange转化为range
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }
}

// MARK: 字符串转成成其他类型,

extension String {
    /**  字符串转Int  */
    func toInt() -> Int {
        return Int((self as NSString).intValue)
    }

    /**  字符串转Float */
    func toFloat() -> Float {
        let scanner = Scanner(string: self)
        var float: Float = 0
        if scanner.scanFloat(&float) {
            return float
        }
        return 0.0
    }

    /**  字符串转Double  */
    func toDouble() -> Double {
        let scanner = Scanner(string: self)
        var double: Double = 0
        if scanner.scanDouble(&double) {
            return double
        }
        return 0.00
    }

    /**  字符串转Bool  */
    func toBool() -> Bool {
        if self == "true" || self == "false" || self == "yes" || self == "no" {
            return (self as NSString).boolValue
        }
        return false
    }

    /**  字符串转成数组 separator 间隔符 */
    func transToArray(separator: String) -> [String] {
        let str = components(separatedBy: separator)
        return str
    }

    /**  JSON字符串转成数组 */
    func getArrayFromJSONString() -> NSArray? {
        let jsonData: Data = data(using: .utf8)!

        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as? NSArray
        }
        return array as? NSArray
    }

    /// 日期字符串转化为Date类型
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    /// - Returns: Date类型
    static func stringConvertDate(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }

    func convertToTime(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self)
        return Int(date?.timeIntervalSince1970 ?? 0)
    }
}

// MARK: - 字符串的匹配

public extension String {
    /// 正则，找出指定字符串
    internal func regexGetSub(pattern: String) -> [String] {
        var subStr: [String] = []
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: self, options: [], range: NSRange(startIndex..., in: self))
        for match in matches {
            let matchStr = (self as NSString).substring(with: match.range)
            subStr.append(matchStr)
        }
        return subStr
    }

    /// 字符串的匹配范围 方法一
    ///
    /// - Parameters:
    ///     - matchStr: 要匹配的字符串
    /// - Returns: 返回所有字符串范围
    func exMatchStrRange(matchStr: String) -> [NSRange] {
        var allLocation = [Int]() // 所有起点
        let matchStrLength = (matchStr as NSString).length // currStr.characters.count 不能正确统计表情
        let arrayStr = components(separatedBy: matchStr)
        var currLoc = 0
        arrayStr.forEach { currStr in
            currLoc += (currStr as NSString).length
            allLocation.append(currLoc)
            currLoc += matchStrLength
        }
        allLocation.removeLast()
        return allLocation.map { NSRange(location: $0, length: matchStrLength) } // 可把这段放在循环体里面，同步处理，减少再次遍历的耗时
    }

    /// 字符串的匹配范围 方法二(推荐)
    ///
    /// - Parameters:
    ///     - matchStr: 要匹配的字符串
    /// - Returns: 返回所有字符串范围
    func exMatchStrNSRange(matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: matchStr.count).joined(separator: "")
        if matchStr == withStr { withStr = withStr.lowercased() } // 临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location, length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }

    func rangeOf(string: String) -> NSRange {
        let selfStr = self as NSString
        return selfStr.range(of: string)
    }
}

// MARK: - 字符串大小

public extension String {
    func heightForView(font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }

    func getTextSize(size: CGSize, attributesDict: [NSAttributedString.Key: Any]) -> CGSize {
        let str = self as NSString
        return str.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributesDict, context: nil).size
    }

    func sizeLineFeedWith(font: UIFont, width: CGFloat) -> CGFloat {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        textView.text = self
        textView.font = font
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let constraint = textView.sizeThatFits(size)
        return constraint.height
    }

    /** 获取字符串尺寸--私有方法 */
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }

        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }

        return CGSize.zero
    }

    /** 获取字符串高度H */
    internal func getNormalStrH(strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }

    /** 获取字符串宽度W */
    internal func getNormalStrW(strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
}

/// 改变字符串中数字的颜色和字体
extension String {
    /// 改变字符串中数字的颜色和字体
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - font: 字体
    ///   - regx: 正则 默认数字 "\\d+"
    /// - Returns: attributeString

    func modifyNumberColor(color: UIColor,
                           font: UIFont,
                           regx: String = "([0-9]\\d*\\.?\\d*)") -> NSMutableAttributedString
    {
        let attributeString = NSMutableAttributedString(string: self)
        do {
            // 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: regx, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    [.foregroundColor: color, .font: font],
                    range: item.range
                )
            }
        } catch {
            LogUtil.log("Failed with error: \(error)")
        }
        return attributeString
    }
}

extension String {
    /// 替换手机号中间四位
    ///
    /// - Returns: 替换后的值
    func replacePhone() -> String {
        let start = index(startIndex, offsetBy: 3)
        let end = index(startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return replacingCharacters(in: range, with: "****")
    }

    func isTelNumber() -> Bool {
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        if (regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self) == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true)
        {
            return true
        } else {
            return false
        }
    }
}

//  StringExtensions.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 16/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    public func toLocalize() -> String {
        return getLabelStringByKey(self)
    }

    public func toLocalize(_ value: String) -> String {
        let resource = getLabelStringByKey(self)
        return resource.replacingOccurrences(of: "#", with: value)
    }

    public func toLocalize(_ value: String, value2: String) -> String {
        var resource = getLabelStringByKey(self)
        resource = resource.stringByReplacingFirstOccurrenceOfString(target: "#", withString: value)
        resource = resource.stringByReplacingFirstOccurrenceOfString(target: "#", withString: value2)
        return resource
    }

    public func toLocalizeMsg() -> String {
        return  getMessageStringByKey(self)
    }

    public func toLocalizeMsg(_ value: String) -> String {
        let resource = getMessageStringByKey(self)
        return resource.replacingOccurrences(of: "#", with: value)
    }

    public func toLocalizeMsg(_ value: String, value2: String) -> String {
        var resource = getMessageStringByKey(self)
        resource = resource.stringByReplacingFirstOccurrenceOfString(target: "#", withString: value)
        resource = resource.stringByReplacingFirstOccurrenceOfString(target: "#", withString: value2)
        return resource
    }

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input: NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        var hexString = ""
        for byte in bytes {
            hexString = [hexString, String(format:"%02x", UInt8(byte))].joined()
        }
        return hexString
    }

    func toBase64() -> String {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }

    public func encrypt() -> String? {
        return encryptString(self)
    }

    public func trim() -> String? {
        return self.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
    }

    public func cleanFormatingChars() -> String {
        return self.replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "+", with: "")
    }

    public func convertToLowercaseTr() -> String {
        return self.replacingOccurrences(of: "I", with: "i")
            .replacingOccurrences(of: "İ", with: "i")
            .replacingOccurrences(of: "Ğ", with: "g")
            .replacingOccurrences(of: "Ç", with: "c")
            .replacingOccurrences(of: "Ö", with: "o")
            .replacingOccurrences(of: "Ü", with: "u")
            .replacingOccurrences(of: "Ş", with: "s")
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "ş", with: "s").lowercased()
    }

    subscript (index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    subscript (index: Int) -> String {
        return String(self[index] as Character)
    }

    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }

    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }

    public func substring(with range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return substring(with: startIndex..<endIndex)
    }

        public func htmlAttributedString() -> NSAttributedString? {
            guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
            guard let html = try? NSMutableAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) else { return nil }
            return html
        }

    /*migration bu fonskiyon gerekli mi?
     subscript (r: Range<Int>) -> String {
     let start = characters.index(startIndex, offsetBy: r.lowerBound)
     let end = <#T##String.CharacterView corresponding to `start`##String.CharacterView#>.index(start, offsetBy: r.upperBound - r.lowerBound)
     return self[Range(start ..< end)]
     }
     */
    public func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}

//
//  EQValidation.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 01/01/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit
import XCGLogger

//import Crashlytics

public enum LabelStyle: String {
    case defaultStyle = "default"
    case light = "light"
    case smallLight = "smalllight"
    case bigLight = "biglight"
    case bold = "bold"
    case smallBold = "smallbold"
    case medium = "medium"
    case mediumBold = "mediumbold"
    //case smallMoney = "smallmoney"
    //case lightMoney = "lightmoney"
    //case boldMoney = "boldmoney"
    case small = "small"
    //case large = "large"
    //case largeMoney = "largemoney"
}

public func isTextComponentEmtpy<T>(_ pComponent: T) -> Bool {
    if let vComponent = pComponent as? SpringTextField {
        if let pasStr = vComponent.text {
            if pasStr.length==0 {
                vComponent.animation = "shake"
                vComponent.curve = "easeIn"
                vComponent.duration = 0.4
                vComponent.animate()
                return false
            }
            return true
        }
    }
    return false
}

public func getLabelStringByKey(_ key: String) -> String {
    if Constant.labels.count > 0 {
        if let localizedString = Constant.labels[key] {
            return localizedString
        } else {
            return getMessageStringByKey(key)
        }
    } else {
        return NSLocalizedString(key, comment: key)
    }
}

public func getMessageStringByKey(_ key: String) -> String {
    if Constant.messages.count > 0 {
        if let localizedString = Constant.messages[key] {
            return localizedString
        } else {
            return key
        }
    } else {
        return NSLocalizedString(key, comment: key)
    }
}

public func getCurrencyLocale(_ currencyCode: String) -> String? {
    switch currencyCode {
    case Constant.turkishLira:
        return "tr_TR"
    case Constant.dollar:
        return "en_US"
    case Constant.euro:
        return "es_ES"
    case Constant.pound:
        return "en_GB"
    default :
        return nil
    }
}

public func getUTCDateFormat(_ pDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: pDate)
}

public func getDateString(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "en_GB")
    return formatter.string(from: date)
}

public func getTodayAsJson() -> String {
    let currentDateTime = Date()
    return getDateString(date: currentDateTime, format: "yyyy-MM-dd'T'HH:mm:ss")
}

public func getTodayAsLongFormat() -> String {
    let currentDateTime = Date()
    return getDateString(date: currentDateTime, format: "yyyy-MM-dd HH:mm")
}

public func convertFromJsonDateToHour(pDate: String, isSecond: Bool) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    guard let vDate = dateFormatter.date(from: pDate) else {
        //log.error(["convertFromJsonDateToHour geçersiz date param:", pDate].joined())
        return ""
    }

    dateFormatter.dateFormat = isSecond ? "HH:mm:ss" : "HH:mm"

    let timeStamp = dateFormatter.string(from: vDate)
    return timeStamp
}

public func getDateAsFilterFormat(_ pDate: Date) -> String {
    return getDateString(date: pDate, format: "dd-MM-yyyy")
}
public func getDateAsSimpleFormat(_ pDate: Date) -> String {
    return getDateString(date: pDate, format: "yyyy-MM-dd")
}
public func getDateAsShortFormat(_ pDate: Date) -> String {
    return getDateString(date: pDate, format: "dd.MM.yyyy")
}
public func isWeekend(date: Date) -> Bool {
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let components = calendar!.components([.weekday], from: date)
    //1: Sunday 7: Saturday
    if components.weekday == 1 || components.weekday == 7 {
        return true
    }
    return false
}

public func getMoneyStringWithLocale(_ pAmount: Double, pCurrency: String) -> String {
    let numberFormatter = NumberFormatter()
    guard let vCurrencyLocale = getCurrencyLocale(pCurrency) else {
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return [numberFormatter.string(from: NSNumber(value: pAmount))!, " ", pCurrency].joined()
    }
    numberFormatter.numberStyle = NumberFormatter.Style.currency
    numberFormatter.locale = Locale(identifier: vCurrencyLocale)
    return numberFormatter.string(from: NSNumber(value: pAmount))!
}

public func getMoneySymbolWithLocale(pCurrency: String) -> String {

    guard let vCurrencyLocale = getCurrencyLocale(pCurrency) else {
        return pCurrency
    }
    let locale = Locale(identifier: vCurrencyLocale) //NSLocale.current

    return locale.currencySymbol!
}

public func getMoneyStringWithFourDigit(_ pAmount: Float, pCurrency: String, pWithSymbol: Bool) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.minimumFractionDigits = 4
    numberFormatter.maximumFractionDigits = 4
    if pWithSymbol {
        guard let vCurrencyLocale = getCurrencyLocale(pCurrency) else {
            return [numberFormatter.string(from: NSNumber(value: pAmount))!, " ", pCurrency].joined()
        }
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.locale = NSLocale(localeIdentifier: vCurrencyLocale) as Locale!
        return numberFormatter.string(from: NSNumber(value: pAmount))!
    } else {
        guard let vCurrencyLocale = getCurrencyLocale(pCurrency) else {
            return numberFormatter.string(from: NSNumber(value: pAmount))!
        }
        numberFormatter.locale = NSLocale(localeIdentifier: vCurrencyLocale) as Locale!
        return numberFormatter.string(from: NSNumber(value: pAmount))!
    }
}

public func getMoneyStringWithDecimalPlace(_ pAmount: Double?, pDecimal: NSInteger) -> String {
    var vAmount: Double = 0
    if let amount = pAmount {
        vAmount = amount
    }
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.minimumFractionDigits = pDecimal
    numberFormatter.maximumFractionDigits = pDecimal
    return numberFormatter.string(from: NSNumber(value: vAmount))!
}

public func getAppVersionInfo() -> String {
    guard let releaseVersionNumber: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
        let buidlVersionNumber: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "Cant get client version!"
    }
    return ["v", releaseVersionNumber, " (", buidlVersionNumber, ")"].joined()

}

public func getAppVersion() -> String {
    guard let releaseVersionNumber: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
        return ""
    }
    return ["iosmb:", releaseVersionNumber].joined()
}

public func convertFromAdjoiningDateToSmallDate (_ pDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "yyyyMMdd"
    guard let vDate = dateFormatter.date(from: pDate) else {
        //log.error(["convertFromJsonDateToHour geçersiz date param:", pDate].joined())
        return ""
    }
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let timeStamp = dateFormatter.string(from: vDate)
    return timeStamp
}

public func convertFromAdjoiningDateToYear (_ pDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "yyyyMMdd"
    guard let vDate = dateFormatter.date(from: pDate) else {
        //log.error(["convertFromJsonDateToHour geçersiz date param:", pDate].joined())
        return ""
    }
    dateFormatter.dateFormat = "yyyy"
    let timeStamp = dateFormatter.string(from: vDate)
    return timeStamp
}

public func getDateFromJsonDate(_ pDateStr: String?) -> Date? {
    guard let vDateStr = pDateStr else {
        //log.error("Tarih hatası, getDateFromJsonDate gelen parametre pDateStr : NULL")
        return nil
    }
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

    guard let result =  dateFormatter.date(from: vDateStr) else {
        if vDateStr.length>19 {
            let vNewDateStr = vDateStr.substring(to: vDateStr.index(vDateStr.startIndex, offsetBy: 19))
            if let result =  dateFormatter.date(from: vNewDateStr) {
                return result
            }
        }
        //log.error(["Tarih hatası, getDateFromJsonDate gelen parametre pDateStr:", pDateStr ?? ""].joined())
        return nil
    }
    return result
}

public func convertFromJsonDateToSmallDate(_ pDate: String) -> String {
    let errorDate = "0001-01-01T00:00:00"
    let errorDate2 = "1900-01-01T00:00:00"
    if pDate == errorDate || pDate == errorDate2 {
        return ""
    }
    guard let date = getDateFromJsonDate(pDate) else {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    dateFormatter.locale = Locale(identifier: "en_GB")
    let timeStamp = dateFormatter.string(from: date)
    return timeStamp
}

public func convertFromJsonDateToDate(_ pDate: String) -> String {
    guard let date = getDateFromJsonDate(pDate) else {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    let timeStamp = dateFormatter.string(from: date)
    return timeStamp
}
public func convertFromJsonDateToSimpleDate(_ pDate: String) -> String {
    guard let date = getDateFromJsonDate(pDate) else {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_GB")
    let timeStamp = dateFormatter.string(from: date)
    return timeStamp
}
public func convertFromJsonDateToTime(_ pDate: String) -> String {
    guard let date = getDateFromJsonDate(pDate) else {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.dateFormat = "HH:mm"

    let timeStamp = dateFormatter.string(from: date)
    return timeStamp
}

public func using12hClockFormat() -> Bool {

    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .none
    formatter.timeStyle = .short

    let dateString = formatter.string(from: Date())
    let amRange = dateString.range(of: formatter.amSymbol)
    let pmRange = dateString.range(of: formatter.pmSymbol)

    return !(pmRange == nil && amRange == nil)
}

public func convertMoneyToDouble(_ moneyStr: String, pCurrency: String) -> Double {
    //let locale = NSLocale.currentLocale()
    let formatter = NumberFormatter()
    guard let vCurrencyLocale = getCurrencyLocale(pCurrency) else {
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let vMoneyStr = moneyStr.replacingOccurrences(of: [" ", pCurrency].joined(), with: "")
        if let moneyDouble = formatter.number(from: vMoneyStr)?.doubleValue {
            return moneyDouble
        }
        return 0
    }
    formatter.locale = Locale(identifier: vCurrencyLocale)
    formatter.numberStyle = NumberFormatter.Style.currency
    if let moneyDouble = formatter.number(from: moneyStr)?.doubleValue {
        return moneyDouble
    }
    /*
    let mString = String(moneyStr.characters.dropFirst())
    let converter = NSNumberFormatter()
    converter.decimalSeparator = "."
    if let result = converter.numberFromString(mString) {
        return result.doubleValue
    } else {
        converter.decimalSeparator = ","
        if let result = converter.numberFromString(mString) {
            return result.doubleValue
        }
    }
    */
    return 0
}

public func getMinutesSeconds (_ seconds: Int) -> String {
    let (minute, second) = intToMinutesSeconds (seconds)
    return [String(minute), ":", String(format: "%02d", second)].joined()
}

public func intToMinutesSeconds (_ intValue: Int) -> (Int, Int) {
    return ((intValue % 3600) / 60, ((intValue % 3600) % 60))
}

public func getIbanFormat(_ pIbanNo: String?, pSeperator: Character) -> String {
    guard let iban2 = pIbanNo, iban2.length>25 else {
        return pIbanNo == nil ? "" : pIbanNo!
    }
    var formattedIban=""
    var inx=0
    for chr in iban2.characters {
        if inx % 4 == 0 && inx > 0 {
            formattedIban.append(pSeperator)
        }
        inx += 1
        formattedIban.append(chr)
    }
    return formattedIban
}

public func getCreditCardFormat(_ pCardNo: String?, pSeperator: Character) -> String {
    guard let cardNo = pCardNo, cardNo.count>14 else {
        return pCardNo == nil ? "" : pCardNo!
    }
    if cardNo.contains(String(pSeperator)) {
        return cardNo
    }
    var formattedCardNo=""
    var inx=0
    for chr in cardNo {
        if inx % 4 == 0 && inx > 0 {
            formattedCardNo.append(pSeperator)
        }
        inx += 1
        formattedCardNo.append(chr)
    }
    return formattedCardNo
}

public func lunhCheckCardNumber(card cardNumber: String) -> Bool {
    var sum = 0
    let reversedCharacters = cardNumber.characters.reversed().map { String($0) }
    for (idx, element) in reversedCharacters.enumerated() {
        guard let digit = Int(element) else { return false }
        switch ((idx % 2 == 1), digit) {
        case (true, 9): sum = sum + 9
        case (true, 0...8): sum = sum + (digit * 2) % 9
        default: sum = sum + digit
        }
    }
    return sum % 10 == 0
}

public func validateEmailAddress(eMail: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    if  !emailTest.evaluate(with: eMail) {
        return false
    }
    return true
}

public func getNextMonth(pDate: Date) -> Date? {
    var components = DateComponents()
    components.setValue(1, for: .month)
    return Calendar.current.date(byAdding: components, to: pDate)
}

public func getNextDay(pDate: Date) -> Date? {
    var components = DateComponents()
    components.setValue(1, for: .day)
    return Calendar.current.date(byAdding: components, to: pDate)
}

public func getPreviousMonth(pDate: Date) -> Date? {
    var components = DateComponents()
    components.setValue(-1, for: .month)
    return Calendar.current.date(byAdding: components, to: pDate)
}


public func getDaysBetweenDate(startDate: Date, endDate: Date) -> Int {
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.day], from: startDate, to: endDate)
    return components.day!
}

public func decodeBase64(toImage strEncodeData: String) -> UIImage {
    let dataDecoded  = NSData(base64Encoded: strEncodeData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
    let image = UIImage(data: dataDecoded as Data)
    return image!
}

public func saveUserDefaults<T>(withKey key: String, dict: AnyObject, myType: T.Type) {
    guard let dict = dict as? T else {
        //log.debug("Type mismatch")
        return
    }
    let archiver = NSKeyedArchiver.archivedData(withRootObject: dict)
    UserDefaults.standard.set(archiver, forKey: key)
}

public func getUserDefaults<T>(withKey key: String, myType: T.Type) -> T? {
    let unarchivedObject = getUserDefaultData(withKey: key)
    return unarchivedObject as? T
}

public func getUserDefaultData(withKey key: String) -> Any? {
    guard let data = UserDefaults.standard.object(forKey: key) else {
        return nil
    }
    guard let retrievedData = data as? Data else {
        return nil
    }
    return NSKeyedUnarchiver.unarchiveObject(with: retrievedData)
}

public func getDayName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
    let dayInWeek = dateFormatter.string(from: pDate)
    return dayInWeek
}

public func getShortestDateFormat(_ pDate: String, pSourceFormat: String?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    dateFormatter.dateFormat = pSourceFormat
    let date = dateFormatter.date(from: pDate)
    dateFormatter.dateFormat = "dd MMM"
    let timeStamp = dateFormatter.string(from: date!)
    return timeStamp
}

public func getLocalIdentifier() -> String {
    return Constant.currentLang
}

public func getAgendaCategoryColor(_ id: String) -> UIColor {
    switch id {
    case "0":
        return UIColor(hex: "#A9B80F")
    case "1":
        return UIColor(hex: "#6DF14F")
    case "2":
        return UIColor(hex: "#FB333D")
    case "3":
        return UIColor(hex: "#E04C19")
    case "4":
        return UIColor(hex: "#8C3FF6")
    case "5":
        return UIColor(hex: "#3E43FF")
    case "6":
        return UIColor(hex: "#61C7FF")
    case "7":
        return UIColor(hex: "#ED64D0")
    default: break
    }
    return UIColor.siemensLight()
}

public func getFormatedWeekName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    dateFormatter.dateFormat = "dd MMM"
    let nameOfMonth = dateFormatter.string(from: pDate)
    return nameOfMonth
}

public func getFormatedDayName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    dateFormatter.dateFormat = "dd"
    let nameOfMonth = dateFormatter.string(from: pDate)
    return nameOfMonth
}

public func getFormatedMonthName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    let nameOfMonth = dateFormatter.string(from: pDate)
    return nameOfMonth
}

public func getFormatedMonthShortName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM"
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    let nameOfMonth = dateFormatter.string(from: pDate)
    return nameOfMonth
}

public func getFormatedYearName(_ pDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    dateFormatter.locale =  Locale(identifier: getLocalIdentifier())
    let nameOfMonth = dateFormatter.string(from: pDate)
    return nameOfMonth
}

public func validateCitizenshipID(id: Int64) -> Bool {
    let digits = id.description.characters.map { Int(String($0)) ?? 0 }

    if digits.count == 11 {
        if digits.first != 0 {
            let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
            let second  = (digits[1] + digits[3] + digits[5] + digits[7])

            let digit10 = (first - second) % 10
            let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10

            if (digits[10] == digit11) && (digits[9] == digit10) {
                return true
            }
        }
    }
    return false
}

public func getDateFromString(_ dateStr: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    return dateFormatter.date(from: dateStr)!
}

public func setupSearchBar(searchBar: UISearchBar, placeHolderTitleKey: String) {
    //zkLatestTransactionTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    searchBar.setValue("Cancel".toLocalize(), forKey: "_cancelButtonText")
    searchBar.tintColor = UIColor.siemensLight()
    searchBar.backgroundColor = UIColor.black
    let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
    if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
        let attributeDict = [NSAttributedString.Key.foregroundColor: Style.defaultTextLightColor, NSAttributedString.Key.font: Style.defaultTextNormalFont!]
        searchTextField!.attributedPlaceholder = NSAttributedString(string: placeHolderTitleKey.toLocalize(), attributes: attributeDict)
    }
    //lastTransactionSearchBar.delegate = self
}
public func setBackgroundSearchBar(searchBar: UISearchBar) {
    for subView in searchBar.subviews {
        for view in subView.subviews {
            if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                guard let imageView = view as? UIImageView else {
                    print("cast exception ui image view")
                    continue
                }
                imageView.image = nil
                imageView.backgroundColor = UIColor.rowBackgroundGray()
                return
            }
        }
    }
}

//
//  Created by Enqura Information Technologies
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//

import UIKit

public struct Constant {
    public static var endPointAddress = "https://sirkeci.azurewebsites.net/api/"
    public static var Turkish = "tr"
    public static var English = "en"
    public static var defaultEndpointAddressKey = "ZiraatKatilimEndpointAddress"
    public static var defaultEndpointAddress = ""
    public static var dynamicBackgroundTag = 1000
    public static var outOfScreen: CGFloat = 10000
    public static var screenSize: CGRect = UIScreen.main.bounds
    public static var screenWidth = UIScreen.main.bounds.width
    public static var screenHeight = UIScreen.main.bounds.height
    public static var screenScale: CGFloat = UIScreen.main.scale
    public static var screenCenterX: CGFloat = screenSize.width * 0.5
    public static var screenCenterY: CGFloat = screenSize.height * 0.5
    public static var isSmallScreen = screenHeight == 480
    public static var isSmall5sScreen = screenHeight <= 568
    public static var isPlusDevice = screenHeight >= 736
    public static let last2Weeks = 14
    public static let lastMonth = 30
    public static var navigationBarHeight: CGFloat = 64
    public static var currentLang: String = "tr_TR"
    public static var labels: [String: String] = [String: String]()
    public static var messages: [String: String] = [String: String]()
    public static var turkishLira = "TRY"
    public static var chf = "CHF"
    public static var dollar = "USD"
    public static var euro = "EUR"
    public static var pound = "GBP"
    public static var gold = "XAU"
    public static var sar = "SAR"

    public static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

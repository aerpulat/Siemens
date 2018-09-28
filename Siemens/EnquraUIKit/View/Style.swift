//
//  Style.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 29/07/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

public struct Style {
    //Default: Dark Red Color Scheme
    public static var mainBackgroundColor = UIColor.white
    public static var mainColor = UIColor.siemensDark()
    public static var mainLightColor = UIColor.siemensLight()
    public static var mainDarkColor = UIColor.eqDarkGray()
    //public static var barBackgroundImageName = "navigationbarbackground"
    public static var barBackgroundImageName = "pageHeader2"
    //public static var barBackgroundImageName = "pageHeader1"
    public static var waitingLogoImageName = "circle"
    public static var standbyImageName = "splash"
    
    //    == SiemensSans-Bold
    //    == SiemensSans-Roman
    
    public static var sectionHeaderTitleFont = UIFont(name: "SiemensSans-Bold", size: 14)
    public static var sectionHeaderBackgroundColor = UIColor.black
    public static var sectionHeaderBackgroundColorHighlighted = UIColor.gray
    public static var defaultTextSmallestFont = UIFont(name: "SiemensSans-Roman", size: 10)
    public static var defaultTextSmallFont = UIFont(name: "SiemensSans-Roman", size: 12)
    public static var defaultTextMediumFont = UIFont(name: "SiemensSans-Roman", size: 14)
    public static var defaultTextNormalFont = UIFont(name: "SiemensSans-Roman", size: 16)
    public static var defaultTextColor = UIColor.siemensTextGray()
    public static var defaultTextLightColor = UIColor.headerGray()
    public static var defaultTextBigFont = UIFont(name: "SiemensSans-Roman", size: 24)
    public static var defaultNumberText = UIFont(name: "SiemensSans-Roman", size: 21)
    public static var smallNumberText = UIFont(name: "SiemensSans-Roman", size: 15)
    public static var defaultTextBoldFont = UIFont(name: "SiemensSans-Bold", size: 18)
    public static var defaultTextMediumBoldFont = UIFont(name: "SiemensSans-Bold", size: 14)
    public static var defaultTextSmallBoldFont = UIFont(name: "SiemensSans-Bold", size: 12)
    public static var defaultNumberTextColor = UIColor.eqGreenText()
    public static var defaultTextMenuFont = UIFont(name: "SiemensSans-Bold", size: 16)
    
    /*
    public static var defaultTextHeaderFont = UIFont(name: "Avenir-Heavy", size: 18)
    public static var defaultMoneyEntryFont = UIFont(name: "Avenir-Light", size: 23)
    public static var defaultLargeNumberText = UIFont(name: "Avenir-Medium", size: 26)
    public static var defaultNumberBoldText = UIFont(name: "HelveticaNeue-bold", size: 21)
    public static var defaultLargeText = UIFont(name: "Avenir-Heavy", size: 32)
    public static var defaultLargeMoneyTextColor = UIColor.eqMoneyGray()
    public static var defaultNumberTextLighColor = UIColor.eqGreenLightText()
    public static var sectionHeaderTitleColor = UIColor.eqGray()
    public static var sectionHeaderAlpha: CGFloat = 1.0
    */
    

}


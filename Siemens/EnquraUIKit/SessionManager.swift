//
//  SessionManager.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 01/01/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit
import Foundation

public class SessionManager {
    // MARK: Private properties
    fileprivate var pSettingsList: [String: String] = [String: String]()

    fileprivate var pLanguage: Language = .tr_TR
    fileprivate var pTrustedConnection: Bool?
    fileprivate var pSecretKey: String = ""

    public static var idleTimer = Timer()
    public static var maxIdleTime = 600
    public static var idleTimeCounter = maxIdleTime

    // MARK: Public properties
    public static var passOtpSessionId = ""
    public static let sharedInstance = SessionManager()
    public static var sessionId: String! = ""
    public static var stateId: String?
    public static var verificationCode: String?
    public static var coreBankingToday: Date?
    public static var serverToday: Date?
    public static var serverTime: Date?
    public static var holidays: [String]?
    public static var deletedObject: Any?
    public static var firstLoad = false



    public var language: Language {
        get {
            return pLanguage
        }
        set(pValue) {
           // if !SessionManager.firstLoad {
                if pLanguage != pValue || Constant.labels.count == 0 {
                    loadResourcesByLanguage(pValue)
                }
            //} else {
            //    SessionManager.firstLoad = false
            //}
            self.pLanguage = pValue
        }
    }

    public var labels: [String: String] {
        get {
            //return pLabelList
            return Constant.labels
        }
        set(pValue) {
            //self.pLabelList = pValue
            Constant.labels = pValue
        }
    }

    public var messages: [String: String] {
        get {
            //return pMessageList
            return Constant.messages
        }
        set(pValue) {
            //self.pMessageList = pValue
            Constant.messages = pValue
        }
    }

    public var secretKey: String {
        get {
            if pSecretKey.length == 0 {
                guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                    //logger.error("Info.plist okunamadı.1")
                    return ""
                }
                guard let dict = NSDictionary(contentsOfFile: path) else {
                    //logger.error("Info.plist okunamadı.2")
                    return ""
                }
                //burası cozulecek
                guard let key = dict.value(forKey: ""/*Environment.secretKey*/) as? String else {
                    //logger.error("Info.plist listte ApiString bulunamadı.")
                    return ""
                }
                pSecretKey = key
                //print("secretKey:\ (pSecretKey)")
                return pSecretKey
            }
            return pSecretKey
        }
        set (pValue) {
            self.pSecretKey = pValue
        }
    }
    public var trustedConnection: Bool? {
        get {
            return pTrustedConnection
        }
        set(pValue) {
            self.pTrustedConnection = pValue
        }
    }

    fileprivate init () {
    }

    // MARK: Loading methods
    func loadResourcesByLanguage(_ lang: Language) {
        if lang == .tr_TR {
            Constant.labels = [:] //DataManager.sharedInstance.getResource(LabelTr())
            Constant.messages = [:] //DataManager.sharedInstance.getResource(MessageTr())
            
            Constant.labels["Copyright"] = "© Copyright Siemens AG 2018. Tüm Hakları Saklıdır."
            //Constant.labels["Copyright"] = "© Copyright Siemens AG 2018. All Rights Reserved."

            Constant.labels["UserMail"] = "Mail adresinizi giriniz."
            Constant.labels["UserPassword"] = "Şifre"
            Constant.labels["RememberMe"] = "Beni Hatırla"
            Constant.labels["ForgotPassword"] = "Şifremi Unuttum"
            Constant.labels["Login"] = "Giriş"
            
            //Home page
            Constant.labels["ActualStatus"] = "Güncel Durum"
            Constant.labels["EnergyInfo"] = "Enerji Bilgileri"
            Constant.labels["WorkOrders"] = "İş Emirleri"
            Constant.labels["WheelInfo"] = "Tekerlek Takımı Bilgileri"
            Constant.labels["DepotStatus"] = "Depo Durumu"
            Constant.labels["MonthlyReport"] = "Aylık Raporlar"

            //WorkOrders page
            Constant.labels["UpdateDate"] = "Güncelleme Tarihi"
            Constant.labels["AllTrains"] = "TÜM TRENLER"

            //Open WorkOrders page
            Constant.labels["OpenWorkOrders"] = "Açık İş Emirleri"
            Constant.labels["TrainNumber"] = "Tren No"

            //depot status
            Constant.labels["Kilometer"] = "Kilometre"
            Constant.labels["Arrival"] = "Geliş"
            Constant.labels["Departure"] = "Gidiş"
            Constant.labels["WhoWorks"] = "Kimler Çalışıyor?"
            Constant.labels["TaskList"] = "İş Listesi"
            Constant.labels["Track"] = "Yol"
            Constant.labels["Operation"] = "İşlem"

            //Help screen
            Constant.labels["Help"] = "Yardım"
            Constant.labels["TaskTypes"] = "İş Tipleri"
            Constant.labels["Status"] = "Durumlar"
            Constant.labels["ApprDesc"] = "Açılmış ama başlamamış İşler"
            Constant.labels["StartedDesc"] = "Sahada devam eden işler"
            Constant.labels["WmatlDesc"] = "Malzeme bekleyen işler"
            Constant.labels["WschDesc"] = "Yaklaşan planlı bakım"
            Constant.labels["InprgDesc"] = "Sahada devam eden işler"

            Constant.labels["PmDesc"] = "Planlı bakım işleri"
            Constant.labels["CmDesc"] = "Düzenli bakım işleri"
            Constant.labels["DiagDesc"] = "Hata koduna göre açılan işler"
            Constant.labels["EngDesc"] = "Mühendislik işleri"
            Constant.labels["ModDesc"] = "Modifikasyon işleri"
            Constant.labels["WorkDesc"] = "Sözleşme kapsamında olmayan işler"
            Constant.labels["Clb_tDesc"] = "Sahada devam eden işler"


        } else if lang == .en_US {
            Constant.labels = [:] // DataManager.sharedInstance.getResource(LabelEn())
            Constant.messages = [:] //DataManager.sharedInstance.getResource(MessageEn())
        }
        //Acilacak
        //addNewResourceInDevelopment(language: lang)
        print("resource'lar db den alındı!!")
    }

    private static var privateCustomerAccountBaranchs: [Int] = [Int]()
    public static var customerAccountBaranchs: [Int] {
        get {
            return privateCustomerAccountBaranchs
        }
        set(pValue) {
            self.privateCustomerAccountBaranchs = pValue
        }
    }

    fileprivate static var pCustomerInfo: Any?
    public static var customerInfo: Any? {
        get {
            return pCustomerInfo
        }
        set(pValue) {
            self.pCustomerInfo = pValue
        }

    }

    public static func resetTimer() {
        idleTimeCounter = maxIdleTime
    }

    public static func startIdleTimer() {
        SessionManager.idleTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                                   target: self,
                                                   selector: #selector(SessionManager.timerTick),
                                                   userInfo: nil,
                                                   repeats: true)
    }

    public static func finishSession(_ showAlert: Bool, isTimeOutAlert: Bool, isSessionHistory: Bool) {
        if SessionManager.passOtpSessionId.length>0 {
            print("-------------------------------------------------------------*")
            print("--- Özel sessionID oldugundan finishSession() çalışmaz!!!  ---")
            print("-------------------------------------------------------------*")
            SessionManager.resetTimer()
            return
        }
        self.sessionId = ""
        self.stateId = nil
        self.verificationCode = nil
        self.idleTimeCounter = 0
        self.idleTimer.invalidate()
    }

    @objc static func timerTick() {
        SessionManager.idleTimeCounter -= 1
        //print("zaman azalıyor \ (SessionManager.idleTimeCounter)")
        if SessionManager.idleTimeCounter <= 0 {
            SessionManager.finishSession(true, isTimeOutAlert: true, isSessionHistory: false)
        }
    }
    
    /*
    fileprivate var pMenuTreeList: [MenuTreeListItemResponse]?
    fileprivate var pMenuBurgerList: [MenuTreeItemResponse]?
    fileprivate var pMenuFastList: [MenuTreeItemResponse]?
    fileprivate var pMenuDashList: [MenuTreeItemResponse]?
    
    public var menuTreeList: [MenuTreeListItemResponse]? {
        get {
            return pMenuTreeList
        }
        set(pValue) {
            self.pMenuTreeList = pValue
        }
    }
    
    public var menuBurgerList: [MenuTreeItemResponse]? {
        get {
            return pMenuBurgerList
        }
        set(pValue) {
            self.pMenuBurgerList = pValue
        }
    }
    
    public var menuFastList: [MenuTreeItemResponse]? {
        get {
            return pMenuFastList
        }
        set(pValue) {
            self.pMenuFastList = pValue
        }
    }
    
    public var menuDashList: [MenuTreeItemResponse]? {
        get {
            return pMenuDashList
        }
        set(pValue) {
            self.pMenuDashList = pValue
        }
    }
    */
}

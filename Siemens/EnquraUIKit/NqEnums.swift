//
//  Created by Enqura
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//

import Foundation

enum ParameterTitle: String {
    case Countries = "Countries"
    case UiLabelsTr = "UI.Labels:tr"
    case UiMessagesTr = "UI.Messages:tr"
    case UiLabelsEn = "UI.Labels:en"
    case UiMessagesEn = "UI.Messages:en"
    case ParameterTr = "Parameter:tr"
    case ParameterEn = "Parameter:en"
    case Settings = "Settings"
    case ParameterNoLang = "Parameter"

    var stringValue: String {
        return self.rawValue
    }
    static let allValues = [Countries,
                            UiLabelsTr,
                            UiMessagesTr,
                            UiLabelsEn,
                            UiMessagesEn,
                            ParameterTr,
                            ParameterEn,
                            Settings,
                            ParameterNoLang]
    static let firstPartValues = [UiLabelsTr,
                                  UiMessagesTr,
                                  UiLabelsEn,
                                  UiMessagesEn,
                                  ParameterNoLang,
                                  Settings,
                                  ParameterTr,
                                  ParameterEn]
}


enum PhoneType: String {
    case Cell1 = "cellPhone"
    case Cell2 = "cellPhone2"
    case Home1 = "home1"
    case Home2 = "home2"
    case Work1 = "work1"
    case Work2 = "work2"
    case Fax = "faxNo"
}


enum AuthorizationResult: Int {
    case error = 0
    case authorized = 1
    case notAuthorized = 2
}

enum AccountType: Int {
    case current = 1
    case participation = 2
    //case Credit = 3
}


public enum Language {
    case tr_TR
    case en_US
}
enum Step: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

public enum ParameterPart: Int {
    case firstPart = 1
    case secondPart = 2
    case full = 3
}


//TODO genel parametre yapısından gelecek

var transactionStateList: [String] = ["All", "Waiting", "Completed", "Cancelled", "Failed"]

public enum TransactionStateType: String {
    case none = "None"
    case waiting = "Waiting"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case failed = "Failed"
}

enum ForgotPasswordVerificationType: Int {
    case identity = 0
    case license = 1
    case passport = 2
    case residencePermit = 3
    case debitCard = 4
}

enum ResetPasswordType: Int {
    case removeBlocking = 1
    case sendNewPassword = 2
    case setPassword = 3
}


enum authorizationType: String {
    case none
    case OpenParticipationAccount
    case Change
    case Exchange
    case EftToIban
    case EftToAccount
    case EftToName
    case EftToCreditCard
    case WireToAccount
    case WireToName
    case WireToIban
    case MoneyOrder
    case Mtv
    case TrafficFine
    case EGoldChange
    case EGoldExchange
    case BillPayment
    case Arbitrage
    
    var stringValue: String {
        return self.rawValue
    }
    static let allValues = [authorizationType.OpenParticipationAccount.stringValue,
                            authorizationType.Change.stringValue,
                            authorizationType.Exchange.stringValue,
                            authorizationType.EftToIban.stringValue,
                            authorizationType.EftToAccount.stringValue,
                            authorizationType.EftToName.stringValue,
                            authorizationType.EftToCreditCard.stringValue,
                            authorizationType.WireToAccount.stringValue,
                            authorizationType.WireToName.stringValue,
                            authorizationType.WireToIban.stringValue,
                            authorizationType.MoneyOrder.stringValue,
                            authorizationType.Mtv.stringValue,
                            authorizationType.TrafficFine.stringValue,
                            authorizationType.EGoldChange.stringValue,
                            authorizationType.EGoldExchange.stringValue,
                            authorizationType.BillPayment.stringValue,
                            authorizationType.Arbitrage.stringValue
                            ]
    
}


struct UserDefaultKey {
    static let appLanguage = "NqAppLanguage"
    static let appCustomerNo = "NqAppCustomerNo"
}

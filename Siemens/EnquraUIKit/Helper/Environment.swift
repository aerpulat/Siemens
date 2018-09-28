//
//  Environment.swift
//  ZiraatKatilim
//
//  Created by Enqura on 06/09/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

/**
 publicKeyFile : Proje içinde Utiliy/security altında bulunan PEM uzantılı bir dosyadır. Dosya içinde private key kullanılarak üretilen public key bulunmaktadır.
 secretKey : Api mesajların hash'lenerek gönderilirken kullanılan ortama göre static bir key'dir. Info.plist dosyası içinde saklanır. Burada config key'i bulunur.
 sslPinning : SSL pining TrustKit framework'u ile sağlanır. Her ortam için Info.plist dosyasında TSKConfiguration->TSKPinnedDomains altında, burada tanımlı olan
              endPointAddress'ler için 4 adet TSK ile başlayan keyler set edilir. Bunlardan en önemlisi TSKPublicKeyHashes ile public key tanımı yapılmalıdır.

 bir domain için public key veren komut:
 openssl s_client -servername zk-mobile.ziraatkatilim.com.tr -connect zk-mobile.ziraatkatilim.com.tr:443 | openssl x509 -pubkey -noout |
 openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
 */
import UIKit

public enum EnvironmentType {
    case development
    case test
    case testOut
    case production
    case zkDevelopment
    case zkFixPreProduction
    case zkFix
    case preProd
    case ozZkDevelopment
    case sahaBt
}

public struct Environment {
    //Default: Dev environment
    public static var endPointAddress = "http://172.21.10.41/zkbomni/v1/api/"
    public static var publicKeyFile = "publicdev"
    public static var secretKey = "ApiSecretDev"
    public static var hostAddress = "https://msube.ziraatkatilim.com.tr"
    public static var current: EnvironmentType = .development

    public static func getEndPointAddress(for pCurrent: EnvironmentType = .development) -> String {
        current = pCurrent
        switch current {
        case .development:
            setToDevelopment()
        case .test:
            setToTest()
        case .testOut:
            setToTestOut()
        case .production:
            setToProduction()
        case .zkDevelopment:
            setToZkDevelopment()
        case .zkFixPreProduction:
            setToZkFixPreProduction()
        case .preProd:
            setToZkPreProduction()
        case .zkFix:
            setToZkFix()
        case .ozZkDevelopment:
            setToOzZkDevelopment()
        case .sahaBt:
            setToSahaBt()
        }
        return endPointAddress
    }

    // MARK: ZK Dev Environment
    fileprivate static func setToDevelopment() {
        //endPointAddress = "https://uskudar.azurewebsites.net/api/"
        endPointAddress = "https://gungoren.azurewebsites.net/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK Test Environment
    fileprivate static func setToTest() {
        endPointAddress = "http://172.21.10.41/zkbomnitest/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    fileprivate static func setToTestOut() {

        endPointAddress = "http://zk.enqura.com/zkbomnitest/v1/api/"
        //endPointAddress = "http://213.14.224.31/zkbomnitest/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK Development Environment
    fileprivate static func setToZkDevelopment() {
        endPointAddress = "http://192.168.1.221:5151/api/"
        //endPointAddress = "http://172.21.10.41/zkbomnidev/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }
    
    fileprivate static func setToOzZkDevelopment() {
        endPointAddress = "http://172.21.10.41/zkbomnidev/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }
    
    fileprivate static func setToSahaBt() {
        endPointAddress = "http://213.14.224.31/zkbomnitest/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK Production Environment
    fileprivate static func setToProduction() {
        endPointAddress = "https://msube.ziraatkatilim.com.tr/zkbomni/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK Production Environment
    fileprivate static func setToZkFixPreProduction() {
        endPointAddress = "https://msube.ziraatkatilim.com.tr/zkbomniv1a/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK pre Production Environment
    fileprivate static func setToZkPreProduction() {
        endPointAddress = "http://10.210.10.11/zkbomniprep/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }

    // MARK: ZK pre Production Environment
    fileprivate static func setToZkFix() {
        endPointAddress = "http://10.210.10.11/zkbomnifix/v1/api/"
        publicKeyFile = "publicdev"
        secretKey = "ApiSecretDev"
    }
}

//
//  Created by Enqura Information Technologies
//  Copyright © 2015 Enqura Information Technologies. All rights reserved.
//

import Foundation
import SwiftyRSA

@objc public class Security: NSObject {

}


struct RSAError: Error {
    let description: String
}

private func getPublicKey(name: String) throws -> PublicKey {
    let bundle = Bundle(for: Security.self)
    guard let path = bundle.path(forResource: name, ofType: "pem") else {
        throw RSAError(description: "Couldn't load key for provided path")
    }
    print(bundle.bundlePath)
    let pemString = try String(contentsOf: URL(fileURLWithPath: path))
    let aa = try PublicKey(pemEncoded: pemString)
    return aa
}

public func encryptString(_ str: String) -> String? {
    do {
        let publicKey = try getPublicKey(name: Environment.publicKeyFile)
        let vStr = try ClearMessage(string: str, using: .utf8)
        let encrypted = try vStr.encrypted(with: publicKey, padding: .PKCS1)
        //let data = encrypted.data
        return encrypted.base64String
        //return try SwiftyRSA.encryptString(str, publicKeyPEM: publicKey)
    } catch {
        print("Error info: \(error)")
        return nil
    }
}

/*
func pemKeyString(_ name: String) throws -> String {
    let bundle = Bundle(for: LoginController.self)
    let pubPath = bundle.path(forResource: name, ofType: "pem")!
    return (try NSString(contentsOfFile: pubPath, encoding: String.Encoding.utf8.rawValue)) as String
}
*/

public func jailbroken(application: UIApplication) -> Bool {
    guard let cydiaUrlScheme = NSURL(string: "cydia://package/com.example.package") else {
        return isJailbroken()
    }
    return application.canOpenURL(cydiaUrlScheme as URL) || isJailbroken()
}

public func isJailbroken() -> Bool {
    #if targetEnvironment(simulator)
        return false
    #else

        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") {
            return true
        }

        if canOpen(path: "/Applications/Cydia.app") ||
            canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            canOpen(path: "/bin/bash") ||
            canOpen(path: "/usr/sbin/sshd") ||
            canOpen(path: "/etc/apt") ||
            canOpen(path: "/usr/bin/ssh") {
            return true
        }

        let path = ["/private/", NSUUID().uuidString].joined()
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }

    #endif

}

public func canOpen(path: String) -> Bool {
    let file = fopen(path, "r")
    guard file != nil else { return false }
    fclose(file)
    return true
}

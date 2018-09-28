//
//  Logger.swift
//  ZkUtilityKit
//
//  Created by Ahmet Erpulat on 05/12/2017.
//  Copyright © 2017 Ziraat Katılım. All rights reserved.
//

import XCGLogger
//import Fabric acilacak
//import Crashlytics acilacak

public let logger = XCGLogger.default

public func setupLogger() {
    logger.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "Log/applog", fileLevel: .debug)
    logger.remove(destinationWithIdentifier: XCGLogger.Constants.baseConsoleDestinationIdentifier)
    //logger.add(destination: CrashlyticsLogDestination(owner: logger, identifier: "Crashlytics"))
    //Fabric.with([Crashlytics.self])
}

/* acilacak
public class CrashlyticsLogDestination: BaseDestination {
    override public init(owner: XCGLogger?, identifier: String) {
        super.init(owner: owner, identifier: identifier)
        showDate = false
    }

    override open func output(logDetails: LogDetails, message: String) {
        let args: [CVarArg] = [message]
        if logDetails.level == XCGLogger.Level.info {
            Answers.logCustomEvent(withName: logDetails.functionName, customAttributes: ["Detail": message])
        } else {
            print("------------------------    Ziraat Katılım    ------------------------")
            print(logDetails.functionName)
            print(message)
            print("------------------------    --------------    ------------------------")
            let errLog = NSError(domain: getNameForLogDomain(filename: logDetails.fileName), code: logDetails.lineNumber, userInfo: [logDetails.level.description: message])
            Crashlytics.sharedInstance().recordError(errLog)
        }
        withVaList(args) { (_) -> Void in
            #if DEBUG
                print(" -- debug-- ")
                //print(argp.debugDescription)
            #else
                print(" -- not debug-- ")
                //print(argp.debugDescription)
            #endif
        }
    }
}
*/
 
public func getNameForLogDomain(filename: String) -> String {
    guard let index1 = filename.range(of: "/", options: .backwards)?.lowerBound else {
        return "loggeneral"
    }
    let substring2 = filename.substring(from: index1)
    let index3 = substring2.index(after: substring2.startIndex)
    let substring3 = substring2.substring(from: index3)
    guard let index2 = substring3.range(of: ".", options: .backwards)?.lowerBound else {
        return "loggeneral"
    }
    return substring3.substring(to: index2)
}

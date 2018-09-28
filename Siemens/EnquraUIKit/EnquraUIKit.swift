//
//  EnquraUIKit.swift
//  EnquraUIKit
//
//  Created by Ahmet Erpulat on 13.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit

public protocol EnquraUIKitProtocol {
    func didCallHello()
}

open class EnquraUIKit: NSObject {
    public static let shared = EnquraUIKit()
    public var delegate: EnquraUIKitProtocol?
    
    open func hello() {
        print("Hello from Enqura UI Kit Project. (Check your delegate)")
        EnquraUIKit.shared.delegate?.didCallHello()
    }
}

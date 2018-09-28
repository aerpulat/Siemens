//
//  UITextFieldExtension.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 17/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

public extension UITextField {

    @IBInspectable public var titleKey: String {
        set (key) {
            placeholder = key.toLocalize()
        }
        get {
            return placeholder!
        }
    }
}

//
//  UILabelExtension.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 17/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

extension UILabel {

    @IBInspectable var titleKey: String {
        set (key) {
            text = key.toLocalize()
        }
        get {
            return text!
        }
    }

    @IBInspectable var titleKeyMsg: String {
        set (key) {
            text = key.toLocalizeMsg()
        }
        get {
            return text!
        }
    }
}

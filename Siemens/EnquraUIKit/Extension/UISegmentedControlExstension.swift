//
//  UISegmentedControlExstension.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 18/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

extension UISegmentedControl {

    var titleKey: String {
        set (key) {
            let titles = key.components(separatedBy: ",")
            for i in 0..<titles.count {
               setTitle(titles[i].toLocalize(), forSegmentAt: i)
            }
        }
        get {
            return ""
        }
    }

}

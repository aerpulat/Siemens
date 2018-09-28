//
//  UIApplicationExtension.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 18/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit
import Foundation

extension UIApplication {
    class func topViewController(_ base: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

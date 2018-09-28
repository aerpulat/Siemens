//
//  UIImageViewExtensions.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 02/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

extension UIImageView {
    func blurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

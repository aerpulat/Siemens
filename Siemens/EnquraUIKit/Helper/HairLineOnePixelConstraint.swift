//
//  HairLineOnePixelConstraint.swift
//  EnquraUIKit
//
//  Created by Ahmet Erpulat on 28.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//


class HairlineOnePixelConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.constant = 1.0 / UIScreen.main.scale
    }
}

//
//  ZkSquareCheckButton.swift
//  ZiraatKatilim
//
//  Created by Enqura on 05/02/17.
//  Copyright © 2017 Enqura Information Technologies. All rights reserved.
//

import UIKit
import QuartzCore

class ZkSquareCheckButton: SpringButton {

    fileprivate var pChecked: Bool = false

    @IBInspectable var checked: Bool {
        get {
            return pChecked
        }
        set (checked) {
            pChecked = checked
            if checked {
                self.setImage(UIImage(named: "square_checked"), for: UIControl.State())
                self.tintColor = UIColor.siemensLight()

            } else {
                self.setImage(UIImage(named: "square_unchecked"), for: UIControl.State())
                self.tintColor = Style.defaultTextColor
            }
        }
    }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }

    func configure() {
        self.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(ZkSquareCheckButton.myTouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        self.setTitleColor(Style.defaultTextColor, for: UIControl.State())
        self.setTitleColor(Style.defaultTextColor, for: UIControl.State())
        //self.titleLabel!.font = Style.defaultTextNormalFont!
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: self.imageView!.frame.size.width)
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func myTouchUpInside(_ checkBox: UIButton) {
        self.checked = !pChecked
    }

}

//
//  ZkRadioButton.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 28/10/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

//
//  ZkCheckboxButton.swift
//  ZiraatKatilim
//
//  Created by Enqura on 24/09/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//
import UIKit
import QuartzCore

class ZkRadioButton: UIButton {

    fileprivate var pSelected: Bool = false
    var pSelectedDefault: Bool = true

    @IBInspectable var radioSelected: Bool {
        get {
            return pSelected
        }
        set (selected) {
            pSelected = selected
            if selected {
                self.setImage(UIImage(named: "radiobutton_selected"), for: UIControl.State())
                self.tintColor = UIColor.siemensLight()

            } else {
                self.setImage(UIImage(named: "radiobutton_empty"), for: UIControl.State())
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
        self.addTarget(self, action: #selector(ZkCheckboxButton.myTouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        self.setTitleColor(Style.defaultTextColor, for: UIControl.State())
        self.titleLabel!.font = Style.defaultTextNormalFont!
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: self.imageView!.frame.size.width)
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }

    @IBAction func myTouchUpInside(_ checkBox: UIButton) {
        if pSelectedDefault {
            if self.radioSelected {
                return
            }
        } else {
            return
        }
        self.radioSelected = !pSelected
    }

}

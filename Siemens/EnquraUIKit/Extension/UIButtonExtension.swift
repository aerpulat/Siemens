//  UIButtonExtension.swift
//  ZiraatKatilim
//
//  Created by Enqura Information Technologies on 17/08/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit
import Foundation

public extension UIButton {

    public convenience init(param: Int) {
        self.init()
        self.backgroundColor = UIColor.brown
    }

    @IBInspectable var titleKey: String {
        set (key) {
            for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
                setTitle(key.toLocalize(), for: state)
            }
        }
        get {
            return title(for: UIControl.State())!
        }
    }
/*
    var titleKeyWhite: String {
        set (key) {
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            let multipleAttributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSParagraphStyleAttributeName: style
            ]
            let attrString = NSAttributedString(
                string: key.toLocalize(),
                attributes: multipleAttributes  )
            for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
                setAttributedTitle(attrString, for: state)
            }
        }
        get {
            return title(for: UIControl.State())!
        }
    }
    var titleKeyBlack: String {
        set (key) {
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            let multipleAttributes = [
                NSForegroundColorAttributeName: UIColor.black,
                NSParagraphStyleAttributeName: style
            ]
            let attrString = NSAttributedString(
                string: key.toLocalize(),
                attributes: multipleAttributes  )
            for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
                setAttributedTitle(attrString, for: state)
            }
        }
        get {
            return title(for: UIControl.State())!
        }
    }
    */
    public func setCenterImage() {
        let spacing: CGFloat = 6.0
        let imageSize: CGSize = self.imageView!.image!.size
        self.setTitleColor(UIColor.siemensLight(), for: UIControl.State())
        self.setTitleColor(UIColor.eqDarkGray(), for: UIControl.State.highlighted)
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        self.titleLabel?.font = Style.defaultTextNormalFont
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: self.titleLabel!.text!)
        let fontAttributes = [NSAttributedString.Key.font: self.titleLabel!.font]
        let titleSize = labelString.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        //let titleSize = labelString.size(attributes: [NSFontAttributeName: self.titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        //shadow
        self.layer.shadowColor = UIColor.siemensDark().cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.10

    }
}

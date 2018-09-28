//
//  ZkCheckboxButton.swift
//  ZiraatKatilim
//
//  Created by Enqura on 24/09/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//
import UIKit
import QuartzCore

class ZkCheckboxButton: SpringButton {

    fileprivate var pChecked: Bool = false
  /*
    @IBInspectable var checked: Bool {
        get {
            return self.pChecked
        }
        set(checked) {
            pChecked = checked
            if pChecked {
                self.setImage(UIImage(named: "checkbox_checked"), forState: UIControl.State.Normal)
            } else {
                self.setImage(UIImage(named: "checkbox"), forState: UIControl.State.Normal)
            }
        }
    }
*/
    @IBInspectable var checked: Bool {
        get {
            return pChecked
        }
        set (checked) {
            pChecked = checked
            if checked {
                self.setImage(UIImage(named: "checkbox_checked"), for: UIControl.State())
                self.tintColor = UIColor.siemensLight()

            } else {
                self.setImage(UIImage(named: "checkbox"), for: UIControl.State())
                self.tintColor = Style.defaultTextColor
            }
            /*
            self.animation = "fadeIn"
            self.curve = "linear"
            self.duration = 0.8
            self.animate()
             */
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
        self.setTitleColor(Style.defaultTextColor, for: UIControl.State())
        //self.titleLabel!.font = Style.defaultTextNormalFont!
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: self.imageView!.frame.size.width)
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        //self.setTitle(" aaaa", forState: UIControl.State.Normal)

        //self.setTitle(text.toLocalize(), forState: UIControl.State.Normal)

        //if let image = UIImage(named: "checkbox_checked") {
        //    self.setImage(image, forState: UIControl.State.Normal)
            //self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.imageView!.frame.size.width, bottom: 0, right: self.imageView!.frame.size.width)
            //self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel!.frame.size.width, bottom: 0, right: -self.titleLabel!.frame.size.width)
        //}
        //self.layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func myTouchUpInside(_ checkBox: UIButton) {
        self.checked = !pChecked
    }

}

    /*
    private func _setup() {
        guard let title = self.titleLabel else {
            return
        }
        title.font = Style.defaultTextNormalFont
        title.textColor = Style.defaultTextColor
        //self.backgroundColor = UIColor.clearColor()
        /*
        if let text = currentTitle {
            self.setTitle(text.toLocalize(), forState: UIControl.State.Normal)
        }
        if let image = UIImage(named:"checkbox") {
            self.imageView?.image = image
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.imageView!.frame.size.width, bottom: 0, right: self.imageView!.frame.size.width)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel!.frame.size.width, bottom: 0, right: -self.titleLabel!.frame.size.width)
        }

 
    }

    //@IBAction func myTouchUpInside(checkBox: UIButton) {
    //    checkBox.imageView?.image = UIImage(named: "checkbox_checked")
    //}
    /*
    @IBInspectable var checked: Bool {
        get {
            return self.pChecked
        }
        set(checked) {
            pChecked = checked
        }
    }
    */
*/*/

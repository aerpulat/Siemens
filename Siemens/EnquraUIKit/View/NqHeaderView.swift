//
//  NqHeaderView.swift
//  EnquraUIKit
//
//  Created by Ahmet Erpulat on 17.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit

public protocol NqHeaderDelegete {
    func onBackButtonPressed()
    func onMessageButtonPressed()
}

//@objc(NqHeaderView)
@IBDesignable public class NqHeaderView: UIView {
    public var view: UIView!
    @IBOutlet weak public var backButton: NqCircleButton!
    @IBOutlet weak public var messageButton: NqCircleButton!
    @IBOutlet weak public var headerLabel: NqLabel!
    public var delegate: NqHeaderDelegete?
    
    @IBInspectable
    public var titleKey: String? {
        didSet {
            if let vKey = self.titleKey {
                headerLabel.text = vKey.toLocalize()
            }
        }
    }
    
    @IBInspectable
    public var hasMessageButton: Bool = true {
        didSet {
            self.messageButton.isHidden = !self.hasMessageButton
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        //messageButton.cap = 30
        view = loadViewFromNib()
        
        //self.setSubViewForAutoLayout(self.stackView)
        //self.backgroundColor = UIColor.darkGray
        self.headerLabel.textColor = UIColor.siemens()
        self.headerLabel.font = Style.defaultTextBoldFont
        addSubview(view)
        /*
        if hasTopNotch {
            view.frame = CGRect(x: 0, y: -44, width: view.superview!.frame.width, height: view.superview!.frame.height + 44)
        } else {
            view.frame = CGRect(x: 0, y: -20, width: view.superview!.frame.width, height: view.superview!.frame.height + 20)
        }
        */
        
        view.frame = CGRect(x: 0, y: 0, width: view.superview!.frame.width, height: view.superview!.frame.height)
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        self.backgroundColor = UIColor.clear
        self.superview?.backgroundColor = UIColor.clear
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.onBackButtonPressed()
    }
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        delegate?.onMessageButtonPressed()
    }
    
    /*
    public func addConstraints() {
        if let vParentView = view.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let trailingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
                , toItem: vParentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 30)
            
            let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
                , toItem: vParentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 30)
            
            let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal
                , toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 50)
            
            let topRightViewTopConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal
                , toItem: vParentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 50)
            NSLayoutConstraint.activate([trailingConstraint, leadingConstraint, heightConstraint, topRightViewTopConstraint])
        }
    }
    */
    /*
    public func setViewFrame(_ index: Int) {
        view.frame = CGRect(x: 0, y: CGFloat(index * 120), width: Constant.screenWidth - 120, height: 120)
        self.topConstraint = CGFloat(index * 120)
        self.index = index
    }
    */
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NqHeaderView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        }
        return UIView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    fileprivate var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }

    
    
    fileprivate var hasTopSafeArea: Bool {
        return true
    }
}



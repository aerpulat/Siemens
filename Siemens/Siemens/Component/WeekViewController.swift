//
//  WeekView.swift
//  Enqura
//
//  Created by Enqura Information Technologies
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.

import UIKit

protocol WeekViewDelegate{
    func dayChanged(selectedDate: Date)
}

@IBDesignable class WeekView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var weekViewDelegate:WeekViewDelegate?
    var stepCount:CGFloat=3
    
    var view: UIView!
    
    /*
    var getCurrentStep: Int {
        get {
            return currentStep
        }
    }
    @IBInspectable var image: UIImage? {
        get {
            return step1Button.backgroundImage(for: UIControl.State())
        }
        set(image) {
            step1Button.setBackgroundImage(image, for: UIControl.State())
        }
    }
    */


    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeekView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        }
        return UIView()
    }

}

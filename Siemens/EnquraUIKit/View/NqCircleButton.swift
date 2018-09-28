//
//
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//
//  Storybord a eklenen button'un width ve height constraints'leri olmak zorundadir.
//  Bu iki constraint cap degeri ile ezilir. Tam kare seklinden cornerRadius ile yuvarlaga donusturulur. default:40
//  insideColorCode : //0:white, 1:siemens gradient default 0white


import UIKit

@IBDesignable
public class NqCircleButton: UIButton {
    
    @IBInspectable
    public var cap: CGFloat = 40
    
    @IBInspectable
    public var insideColorCode: CGFloat = 0.0 //0:white, 1:siemens gradient

    var heightConstaint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .height, $0.relation == .equal {
                    return true
                }
                return false
                }.first
        }
        set{ setNeedsLayout() }
    }
    
    var widthConstaint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .width, $0.relation == .equal {
                    return true
                }
                return false
                }.first
        }
        set{ setNeedsLayout() }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    override open class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    func configure() {
        self.setTitleColor(UIColor.white, for: UIControl.State())
        self.titleLabel!.font = Style.defaultTextBoldFont
        if self.insideColorCode == 1 {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.colors = [UIColor.siemensDark().cgColor, UIColor.siemensLight().cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0,y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
            gradientLayer.locations = nil
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.siemensDark().cgColor
        } else if self.insideColorCode == 0 {
            self.layer.shadowColor = UIColor.black.cgColor
            self.backgroundColor = UIColor.white
        }

        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.15

        if let hh = self.heightConstaint {
            hh.constant = self.cap
        }
        if let ww = self.widthConstaint {
            ww.constant = self.cap
        }
        self.layer.cornerRadius = self.cap / 2

    }
    
}

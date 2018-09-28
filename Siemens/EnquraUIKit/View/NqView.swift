//
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public class NqView: SpringView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var insideColorCode: CGFloat = 0.0 //0:white, 1:siemens gradient 2:siemens gray

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    func configure() {
        self.layer.masksToBounds = false
        if self.insideColorCode == 1 {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.colors = [UIColor.siemensDark().cgColor, UIColor.siemensLight().cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0,y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
            gradientLayer.locations = nil
            self.layer.shadowColor = UIColor.siemensDark().cgColor
        } else if self.insideColorCode == 2 {
            self.layer.backgroundColor = UIColor.siemensGray().cgColor
            self.layer.shadowColor = UIColor.black.cgColor
        } else if self.insideColorCode == 3 {
            let color = UIColor.headerGray()
            self.backgroundColor = color.withAlphaComponent(0.2)
            self.layer.shadowColor = UIColor.black.cgColor
        } else {
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.shadowColor = UIColor.black.cgColor
        }

        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.1

        for element in self.subviews {
            var corners = UIRectCorner()
            //sol ust kose kirpilacak mi
            if element.frame.origin.x < self.cornerRadius && element.frame.origin.y < self.cornerRadius {
                corners.insert(.topLeft)
            }
            //sag ust kose kirpilacak mi
            if element.frame.origin.x + element.frame.width - self.frame.size.width > -1*self.cornerRadius
                && element.frame.origin.y < self.cornerRadius {
                corners.insert(.topRight)
            }
            //sol alt kose kirpilacak mi
            if element.frame.origin.x < self.cornerRadius
                && element.frame.origin.y + element.frame.height - self.frame.size.height > -1*self.cornerRadius {
                corners.insert(.bottomLeft)
            }
            //sag alt kose kirpilacak mi
            if element.frame.origin.x + element.frame.width - self.frame.size.width > -1*self.cornerRadius
                && element.frame.origin.y + element.frame.height - self.frame.size.height > -1*self.cornerRadius {
                corners.insert(.bottomRight)
            }

            if !corners.isEmpty {
                let path = UIBezierPath(roundedRect:element.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: self.cornerRadius, height:  self.cornerRadius))
                
                let maskLayer = CAShapeLayer()
                maskLayer.path = path.cgPath
                element.layer.mask = maskLayer
            }
        }
    }
    
    public var heightConstaint: NSLayoutConstraint? {
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
}

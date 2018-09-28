//
//
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public class NqButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
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
        //self.backgroundColor = UIColor.
        self.setTitleColor(UIColor.white, for: UIControl.State())
        self.titleLabel!.font = Style.defaultTextBoldFont
        //self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        //self.titleLabel?.textAlignment = NSTextAlignment.left
        
        
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [UIColor.siemensDark().cgColor, UIColor.siemensLight().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
        gradientLayer.locations = nil
        gradientLayer.cornerRadius = 5.0
        gradientLayer.frame.size.height = 55.0
        
        self.layer.shadowColor = UIColor.siemensDark().cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.15
        addHeightConstraint ()
    }

    private func addHeightConstraint () {
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([heightConstraint])
        //self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
}

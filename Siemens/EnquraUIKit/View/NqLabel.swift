//  Created by Enqura
//  Copyright © 2018 Enqura Information Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public class NqLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //configure()
    }

    // Swift: use the enum
    var style = LabelStyle.defaultStyle
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.clipsToBounds = true
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'style' instead.")
    @IBInspectable var styleName: String? {
        willSet {
            if let newStyle = LabelStyle(rawValue: newValue?.lowercased() ?? "") {
                style = newStyle
            }
        }
        didSet {
            switch style {

            case .defaultStyle:
                self.font =  Style.defaultTextNormalFont
                self.textColor = Style.defaultTextColor
            case .medium:
                self.font =  Style.defaultTextMediumFont
                self.textColor = Style.defaultTextColor
            case .small:
                self.font =  Style.defaultTextSmallFont
                self.textColor = Style.defaultTextColor
            case .bigLight:
                self.font =  Style.defaultTextBigFont
                self.textColor = UIColor.white
            case .bold:
                self.font =  Style.defaultTextBoldFont
                self.textColor = Style.defaultTextColor
            case .light:
                self.font =  Style.defaultTextNormalFont
                self.textColor = Style.defaultTextLightColor
                /*
            case .lightMoney:
                self.font =  Style.defaultNumberText
                self.textColor = Style.defaultNumberTextLighColor
            case .smallMoney:
                self.font =  Style.smallNumberText
                self.textColor = Style.defaultTextColor
            case .money:
                self.font =  Style.defaultNumberText
                self.textColor = Style.defaultNumberTextColor
            case .largeMoney:
                self.font =  Style.defaultLargeNumberText
                self.textColor = Style.defaultLargeMoneyTextColor
                */
            case .mediumBold:
                self.font =  Style.defaultTextMediumBoldFont
                self.textColor = Style.defaultTextColor
            case .smallBold:
                self.font =  Style.defaultTextSmallBoldFont
                self.textColor = Style.defaultTextColor
            case .smallLight:
                self.font =  Style.defaultTextSmallFont
                self.textColor = Style.defaultTextLightColor
            //case .boldMoney:
            //    self.font =  Style.defaultNumberBoldText
            //    self.textColor = Style.defaultNumberTextColor
            //case .large:
            //    self.font =  Style.defaultLargeText
            //    self.textColor = Style.defaultTextColor
            //
                
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //configure()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        //configure()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //configure()
    }
/*
    func configure() {
        self.font =  Style.defaultTextNormalFont
        self.textColor = Style.defaultTextColor
    }
 */
}

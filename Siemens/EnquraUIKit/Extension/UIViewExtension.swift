//
//  UIViewExtension.swift
//  EnquraUIKit
//
//  Created by Ahmet Erpulat on 19.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit

extension UIView {
   
    // Ekran arkasina default_background isimli image i yerlestirir. default_backround, framework projesinde DEGIL
    // kendi projenize bu isimde image eklenmelidir. Ayrica istenilen farkli image ler parametre olarak da verilebilir.
   public func addBackground(imageName: String = "content_bg", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(backgroundImageView)
        sendSubviewToBack(_: backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    public func addCopyright() {
        let label = UILabel(frame: CGRect(x: 0, y: Constant.screenHeight - 32.0, width: Constant.screenWidth, height: 14.0))
        label.font = Style.defaultTextSmallestFont
        label.textColor = Style.defaultTextColor
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "Copyright".toLocalize()
        addSubview(label)
    }
    
}

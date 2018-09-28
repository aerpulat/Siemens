//
//  LoginController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 25.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import EnquraUIKit

class LoginController: UIViewController {
    @IBOutlet weak var langButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: NqButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureTextFields()
        self.view.addCopyright()
        print("Hello".toLocalize())
    }
    
    
    fileprivate func configureButton() {
        self.langButton.layer.borderColor = UIColor.siemens().cgColor
        self.langButton.layer.borderWidth = 1.0
        self.langButton.layer.cornerRadius = 20.0
    }
    
    fileprivate func configureTextFields() {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        iconView.image = UIImage(named: "user_login")
        iconView.backgroundColor = UIColor.clear
        iconView.contentMode = .center
        self.usernameTextField.leftView = iconView
        self.usernameTextField.font = Style.defaultTextNormalFont
        self.usernameTextField.textColor = Style.defaultTextColor
        self.usernameTextField.tintColor = UIColor.siemens()
        self.usernameTextField.leftViewMode = UITextFieldViewMode.always

        let vView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        vView.image = UIImage(named: "password_login")
        vView.backgroundColor = UIColor.clear
        vView.contentMode = .center
        self.passwordTextField.leftView = vView
        self.passwordTextField.font = Style.defaultTextNormalFont
        self.passwordTextField.textColor = Style.defaultTextColor
        self.passwordTextField.tintColor = UIColor.siemens()
        self.passwordTextField.leftViewMode = UITextFieldViewMode.always

    }
}

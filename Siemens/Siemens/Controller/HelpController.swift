//
//  HelpController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 28.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import EnquraUIKit

class HelpController: UIViewController {
    @IBOutlet weak var pageHeader: NqHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addCopyright()
        self.view.addBackground()
        self.pageHeader.delegate = self
    }
    
}

extension HelpController: NqHeaderDelegete {
    func onBackButtonPressed() {
        self.goBack()
    }
    
    func onMessageButtonPressed() {
        //
    }
}



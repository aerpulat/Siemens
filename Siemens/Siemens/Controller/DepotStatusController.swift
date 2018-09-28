//
//  DepotStatusController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 27.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//



import UIKit
import EnquraUIKit

class DepotStatusController: UIViewController {
    @IBOutlet weak var pageHeader: NqHeaderView!
    @IBOutlet weak var dateView: NqView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addCopyright()
        self.view.addBackground()
        self.pageHeader.delegate = self
        configureLabels()
        self.view.addCopyright()
        //dateView.backgroundColor = UIColor.headerGray()
    }
    
    func configureLabels() {
    }
}

extension DepotStatusController: NqHeaderDelegete {
    func onBackButtonPressed() {
        self.goBack()
    }
    
    func onMessageButtonPressed() {
        //
    }
}

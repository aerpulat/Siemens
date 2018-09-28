//
//  DepotStatusController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 27.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//


import UIKit
import EnquraUIKit

class DepotStatusDetailController: UIViewController {
    @IBOutlet weak var pageHeader: NqHeaderView!
    @IBOutlet weak var trackNameLabel: NqLabel!
    @IBOutlet weak var energyTypeLabel: NqLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addCopyright()
        self.view.addBackground()
        self.pageHeader.delegate = self
        configureLabels()
        self.view.addCopyright()
    }
    
    func configureLabels() {
        trackNameLabel.textColor = UIColor.white
        trackNameLabel.font = Style.defaultTextMenuFont
        energyTypeLabel.textColor = UIColor.white
        energyTypeLabel.font = Style.defaultTextSmallFont
    }
}

extension DepotStatusDetailController: NqHeaderDelegete {
    func onBackButtonPressed() {
        self.goBack()
    }
    
    func onMessageButtonPressed() {
        //
    }
}

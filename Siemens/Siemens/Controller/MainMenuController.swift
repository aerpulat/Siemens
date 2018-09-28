//
//  MainMenuController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 25.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import EnquraUIKit

class MainMenuController: UIViewController {
    
    @IBOutlet weak var actualStatusButton: UIButton!
    @IBOutlet weak var energyButton: UIButton!
    @IBOutlet weak var wheelButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var depotStatus: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    @IBOutlet weak var profileButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileButton.layer.cornerRadius = 20.0
        self.view.addBackground(imageName: "homepage_bg", contentMode: UIView.ContentMode.scaleAspectFill)
        self.view.addCopyright()
        
        self.actualStatusButton.setCenterImage()
        self.energyButton.setCenterImage()
        self.wheelButton.setCenterImage()
        self.orderButton.setCenterImage()
        self.depotStatus.setCenterImage()
        self.reportButton.setCenterImage()

    }
    

}

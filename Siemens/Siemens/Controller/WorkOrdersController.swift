//
//  WorkOrdersController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 27.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import EnquraUIKit

class WorkOrdersController: UIViewController {
    @IBOutlet weak var pageHeader: NqHeaderView!
    @IBOutlet weak var trainTableView: UITableView!
    @IBOutlet weak var dateLabel: NqLabel!
    fileprivate let AllTrains:Int = 0
    var trainList: [TrainResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addCopyright()
        self.view.addBackground()
        self.pageHeader.delegate = self
        fillScreen()
        self.trainTableView.delegate = self
        self.trainTableView.dataSource = self
        self.trainTableView.tableFooterView = UIView(frame: .zero) //table not selectable
        self.trainTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.trainTableView.reloadData()
    }
    
    func fillScreen() {
        for i in 0...10 {
            let train1 = TrainResponse()
            train1.name = String(80001 + i)
            trainList.append(train1)
        }
    }
}

extension WorkOrdersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trainTableView.dequeueReusableCell(withIdentifier: "trainNameCell", for: indexPath) as? TrainNameTableCell
        let selectedIndex = indexPath.row
        cell!.trainNameButton.setTitle(self.trainList[selectedIndex].name, for: .normal)
        cell!.trainNameButton.setTitleColor(UIColor.white, for: .normal)
        cell!.trainNameButton.setTitleColor(UIColor.siemensLight(), for: .highlighted)
        cell!.trainNameButton.titleLabel!.font = Style.defaultTextNormalFont
        cell!.trainNameButton.tag = selectedIndex
        cell!.trainNameButton.addTarget(self, action: #selector(WorkOrdersController.trainSelected(_:)), for: UIControlEvents.touchUpInside)
        
        if selectedIndex == AllTrains {
            cell!.trainNameButton.setTitle("AllTrains".toLocalize(), for: .normal)
            cell!.trainNameButton.setImage(nil, for: .normal)
            if let gradientLayer = cell!.trainNameButton.layer as? CAGradientLayer {
                gradientLayer.colors = [UIColor.siemensGray().cgColor, UIColor.siemensGray().cgColor]
            }
            cell!.trainNameButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell!.trainNameButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

            cell!.trainNameButton.titleLabel!.font = Style.defaultTextMenuFont
            cell!.trainNameButton.tag = selectedIndex
            cell!.trainNameButton.addTarget(self, action: #selector(WorkOrdersController.trainSelected(_:)), for: UIControlEvents.touchUpInside)
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58.0
    }
    
    @objc func trainSelected(_ button: NqButton) {
        print(button.tag)
        performSegue(withIdentifier: "openWorkOrdersSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("değişkeni gönder")
    }
    
}


extension WorkOrdersController: NqHeaderDelegete {
    func onBackButtonPressed() {
        self.goBack()
    }
    
    func onMessageButtonPressed() {
        //
    }
}

class TrainNameTableCell: UITableViewCell {
    @IBOutlet weak var trainNameButton: NqButton!
}

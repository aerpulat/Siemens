//
//  OpenWorkOrdersController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 27.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import EnquraUIKit

class OpenWorkOrdersController: UIViewController {
    @IBOutlet weak var pageHeader: NqHeaderView!
    @IBOutlet weak var workOrderTableView: UITableView!
    @IBOutlet weak var dateLabel: NqLabel!
    @IBOutlet weak var trainNoHaderLabel: NqLabel!
    fileprivate let AllTrains:Int = 0
    
    @IBOutlet weak var boardApprLabel: NqLabel!
    @IBOutlet weak var boardStartedLabel: NqLabel!
    @IBOutlet weak var boardWmatlLabel: NqLabel!
    @IBOutlet weak var boardWschLabel: NqLabel!
    @IBOutlet weak var boardInprgLabel: NqLabel!

    @IBOutlet weak var totalApprLabel: UILabel!
    @IBOutlet weak var totalStartedLabel: UILabel!
    @IBOutlet weak var totalWmatlLabel: UILabel!
    @IBOutlet weak var totalWschLabel: UILabel!
    @IBOutlet weak var totalInprgLabel: UILabel!

    
    var trainList: [TrainResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addCopyright()
        self.view.addBackground()
        self.pageHeader.delegate = self
        fillScreen()
        self.workOrderTableView.delegate = self
        self.workOrderTableView.dataSource = self
        self.workOrderTableView.tableFooterView = UIView(frame: .zero) 
        self.workOrderTableView.separatorStyle = .none
        configureLabels()
        trainNoHaderLabel.textColor = UIColor.white
    }
    
    fileprivate func configureLabels() {
    }
    
    func fillScreen() {
        for i in 0...10 {
            let train1 = TrainResponse()
            train1.name = String(80001 + i)
            train1.appr = Int.random(in: 0..<99)
            train1.started = Int.random(in: 0..<99)
            train1.wsch = Int.random(in: 0..<99)
            train1.wmatl = Int.random(in: 0..<99)
            train1.inprg = Int.random(in: 0..<99)
            trainList.append(train1)
        }
    }
}

extension OpenWorkOrdersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workOrderTableView.dequeueReusableCell(withIdentifier: "openWorkOrderTableCell", for: indexPath) as? OpenWorkOrderTableCell
        let selectedItem: TrainResponse = trainList[indexPath.row]
        cell!.trainNameLabel.text = selectedItem.name
        cell!.trainNameLabel.textColor = UIColor.white
        cell!.apprLabel.text = String(selectedItem.appr ?? 0)
        cell!.startedLabel.text = String(selectedItem.started ?? 0)
        cell!.wschLabel.text = String(selectedItem.wsch ?? 0)
        cell!.wmatlLabel.text = String(selectedItem.wmatl ?? 0)
        cell!.inprgLabel.text = String(selectedItem.inprg ?? 0)
        if indexPath.row % 2 == 0 {
            cell!.backgroundColor = UIColor.rowBackgroundGray()
        } else {
            cell!.backgroundColor = UIColor.white
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37.5
    }
    
    @objc func trainSelected(_ button: NqButton) {
        print(button.tag)
    }
    
}


extension OpenWorkOrdersController: NqHeaderDelegete {
    func onBackButtonPressed() {
        self.goBack()
    }
    
    func onMessageButtonPressed() {
        //
    }
}

class OpenWorkOrderTableCell: UITableViewCell {
    @IBOutlet weak var trainNameLabel: NqLabel!
    @IBOutlet weak var apprLabel: NqLabel!
    @IBOutlet weak var startedLabel: NqLabel!
    @IBOutlet weak var wmatlLabel: NqLabel!
    @IBOutlet weak var wschLabel: NqLabel!
    @IBOutlet weak var inprgLabel: NqLabel!
}


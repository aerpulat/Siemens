//
//  UITableViewExtension.swift
//  ZiraatKatilim
//
//  Created by Enqura on 01/10/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//

import UIKit

public extension UITableView {

    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }

    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func scrollToBottom() {
        let sections = numberOfSections-1
        if sections >= 0 {
            let rows = numberOfRows(inSection: sections)-1
            if rows >= 0 {
                let indexPath = IndexPath(row: rows, section: sections)
                DispatchQueue.main.async { [weak self] in
                    self?.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
}

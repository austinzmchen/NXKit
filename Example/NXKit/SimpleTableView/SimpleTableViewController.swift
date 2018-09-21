//
//  SimpleTableViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-09-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

class SimpleTableViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
}

extension SimpleTableViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "kNameCell"
        static let CatCell = "kCategoryCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: .init(rawValue: "kSimpleTableCell"), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = "Dummy Cell"
            return cell
        }
        return nil
    }
    
    // equivalent to didSelectcell on iOS
    func tableViewSelectionDidChange(_ notification: Notification) {
        let indexSet = tableView.selectedRowIndexes
        for i in indexSet {
            print(i)
        }
    }
    
    @objc func tableViewDoubleClicked(_ sender: Any) {
    }
}

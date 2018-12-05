//
//  SimpleTableViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-09-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class SimpleTableViewController: NSViewController {
    
    @IBOutlet weak var tableView: NXTableView!
    
    private var eventMonitor: EventMonitor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // detect key down method 1
        tableView.accepts1stResponder = true
        tableView.addTarget(self, action: { (event, info) in
            guard let key = info as? KeyCode.RawType else {return}
            if key == KeyCode.s {
                print(key)
            }
            print(key)
        }, for: .keyUp)
        
        // detect key down method 2
        eventMonitor = EventMonitor.init(mask: .keyUp) { (event) -> NSEvent? in
            if event.keyCode == KeyCode.delete {
                print("delete")
            }
            return event
        }
        eventMonitor?.start()
    }
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
        if var cell = tableView.makeView(withIdentifier: .init(rawValue: "kSimpleTableCell"), owner: nil) as? NSTableCellView {
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
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        print("shouldSelectRow")
        return true
    }
    
    func tableViewSelectionIsChanging(_ notification: Notification) {
        print("tableViewSelectionIsChanging")
    }
    
    @objc func tableViewDoubleClicked(_ sender: Any) {}
}

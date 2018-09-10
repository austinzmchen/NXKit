//
//  ViewController.swift
//  NXKit
//
//  Created by Austin Chen on 07/31/2018.
//  Copyright (c) 2018 Austin Chen. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    typealias ItemType = (name: String, cat: String)
    var items: [ItemType] = [
        (name: "SimpleViews", cat: "View"),
        (name: "TextView", cat: "View"),
        (name: "StackView", cat: "View"),
        (name: "SimpleAnimations", cat: "View"),
        (name: "SimplePresentation", cat: "View")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.doubleAction = #selector(tableViewDoubleClicked(_:))
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

extension MainViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
}

extension MainViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "kNameCell"
        static let CatCell = "kCategoryCell"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        let item = items[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.cat
            cellIdentifier = CellIdentifiers.CatCell
        }
        
        if let cell = tableView.makeView(withIdentifier: .init(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
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
        let row = tableView.selectedRow
        if row == 0 {
            performSegue(withIdentifier: "showSimpleViewsVC", sender: nil)
        } else if row == 1 {
            performSegue(withIdentifier: "showTextViewVC", sender: nil)
        } else if row == 2 {
            performSegue(withIdentifier: "showStackViewVC", sender: nil)
        } else if row == 3 {
            performSegue(withIdentifier: "showSimpleAnimationsVC", sender: nil)
        } else if row == 4 {
            performSegue(withIdentifier: "showSimplePresentationVC", sender: nil)
        }
    }
}

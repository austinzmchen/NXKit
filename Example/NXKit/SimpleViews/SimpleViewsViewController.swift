//
//  SimpleViewsViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-01.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

class SimpleViewsViewController: NSViewController {
    
    @IBOutlet weak var button: NSButton!
    @IBAction func buttonTapped(_ sender: Any) {
        menu1.popUp(positioning: nil, at: button.frame.origin, in: view)
    }
    
    @IBOutlet var menu1: NSMenu!
}

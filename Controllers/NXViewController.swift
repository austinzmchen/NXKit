//
//  NXViewController.swift
//  NXKit
//
//  Created by Austin Chen on 2018-09-17.
//

import AppKit

open class NXViewController: NSViewController {
    
    // override loadView because NSViewController() will crash if otherwise
    open override func loadView() {
        self.view = NXView()
    }
}

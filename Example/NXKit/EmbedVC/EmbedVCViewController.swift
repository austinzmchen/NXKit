//
//  EmbedVCViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-09-12.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

class EmbedVCViewController: NSViewController {
    
    weak var childVC: NSViewController?
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "kEmbedVC" {
            childVC = segue.destinationController as! NSViewController
        }
    }
}

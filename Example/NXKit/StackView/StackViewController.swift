//
//  StackViewController.swift
//  SimpleStackView
//
//  Created by Austin Chen on 2018-07-24.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import Cocoa

class StackViewController: NSViewController {

    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var button3: NSButton!
    @IBOutlet weak var button4: NSButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        button1.isHidden = true
        button4.isHidden = true
    }
    
    @IBAction func anotherButtonTapped(_ sender: Any) {
        button1.isHidden = false
        button4.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


//
//  SampleViewController0.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-09-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

class SampleViewController0: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss after defined time interval
        Timer.scheduledTimer(timeInterval: 2.0, target: self,
                             selector: #selector(closeButtonClicked(_:)),
                             userInfo: nil, repeats: false)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(nil)
    }
}

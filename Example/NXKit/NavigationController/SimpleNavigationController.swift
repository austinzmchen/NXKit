//
//  SimpleNavigationController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-09-17.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class SimpleNavigationController: NSViewController {
    
    @IBAction func buttonClicked(_ sender: Any) {
        let vc1 = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("kSampleVC")) as! SampleViewController1
        let navVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("kNavVC")) as! NXNavigationController
        navVC.rootViewController = vc1
        presentAsModalWindow(navVC)
    }
}

//
//  SampleViewController1.swift
//  Example
//
//  Created by Austin Chen on 2018-09-11.
//  Copyright © 2018 phimage. All rights reserved.
//

import AppKit

class SampleViewController1: NSViewController {
    
    @IBOutlet weak var label1: NSTextField!
    
    @IBAction func popButtonClicked(_ sender: Any) {
        _ = navigationController?.popViewController()
    }
    
    @IBAction func pushButtonClicked(_ sender: Any) {
        let destVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("kSampleVC")) as! SampleViewController1
        _ = destVC.view
        destVC.label1.stringValue = "View controller \(navigationController?.viewControllers.count ?? 0)"
        navigationController?.pushViewController(destVC, animated: true)
    }
}

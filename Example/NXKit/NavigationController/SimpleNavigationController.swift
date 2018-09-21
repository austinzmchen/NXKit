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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "kNXConfigured" {
            if let segue = segue as? PresentWithAnimatorSegue {
                if segue.animator == nil {
                    segue.animator = TransitionAnimator()
                }
                
                let animator = segue.animator as! TransitionAnimator
                animator.duration = 1
                animator.transition = [.slideDown/*, .crossfade*/]
                animator.backgroundColor = NSColor(calibratedRed: 1, green: 0, blue: 0, alpha: 0.5)
                animator.keepOriginalSize = true
                animator.removeFromView = false
                
            }
        } else if segue.identifier == "kNXCustomAnimator" {
            if let segue = segue as? PresentWithAnimatorSegue {
                if let frame = segue.source?.view.window?.frame {
                    segue.animator = CustomAnimator(duration: 1.0, rect: frame)
                }
                
            }
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let vc1 = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("kSampleVC")) as! SampleViewController1
        let navVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("kNavVC")) as! NXNavigationController
        navVC.rootViewController = vc1
        presentAsModalWindow(navVC)
    }
}

extension NSStoryboardSegue {
    var source: NSViewController? {
        return self.sourceController as? NSViewController
    }
    var destination: NSViewController? {
        return self.destinationController as? NSViewController
    }
}

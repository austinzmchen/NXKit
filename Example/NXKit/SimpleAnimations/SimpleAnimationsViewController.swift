//
//  SimpleAnimationsViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-28.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

class SimpleAnimationsViewController: NSViewController {
    @IBOutlet weak var view1: NXView!
    @IBOutlet weak var view2: NXView!
    @IBOutlet weak var view2LeadConstraint: NSLayoutConstraint!
    
    @IBAction func button1Clicked(_ sender: Any) {
        animateAlpha2()
    }
    
    @IBAction func button2Clicked(_ sender: Any) {
        animateConstraint1()
    }
    
    private func animateAlpha1() {
        let targetAlpha: CGFloat = self.view1.alphaValue == 0 ? 1 : 0
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 1
            self.view1.animator().alphaValue = targetAlpha
        }, completionHandler: nil)
    }
    
    private func animateAlpha2() {
        let targetAlpha: CGFloat = self.view1.alphaValue == 0 ? 1 : 0
        NSView.animate(withDuration: 1, animations: {
            self.view1.alphaValue = targetAlpha
        })
    }
    
    private func animateConstraint1() {
        let lead = view2LeadConstraint.constant
        let target: CGFloat = lead == 20.0 ? 200 : 20
        NSView.animate(withDuration: 1, animations: {
            self.view2LeadConstraint.constant = target
            self.view2.superview?.layoutSubtreeIfNeeded()
        })
    }
}

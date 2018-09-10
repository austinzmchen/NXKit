//
//  LighthousePresentationAnimator.swift
//  SampleModalSheet
//
//  Created by Austin Chen on 2018-09-08.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import AppKit

class LighthousePresentationAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let fromVC = fromViewController
        let toVC = viewController
        toVC.view.wantsLayer = true
        toVC.view.layer?.backgroundColor = NSColor.init(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1).cgColor
        toVC.view.alphaValue = 0
        
        let containerView = NXView.init(frame: fromVC.view.bounds)
        containerView.layerContentsRedrawPolicy = .onSetNeedsDisplay
        containerView.alphaValue = 0
        containerView.userInfo = containerViewTag
        
        containerView.backgroundColor = NSColor.gray
        fromVC.view.addSubview(toVC.view)
        fromVC.view.addSubview(containerView, positioned: .below, relativeTo: toVC.view)
        
        var f = toVC.view.frame
        f.origin = CGPoint(x: (containerView.frame.width - f.width) / 2,
                           y: (containerView.frame.height - f.height) / 2)
        toVC.view.frame = f

        NSView.animate(withDuration: 0.5, animations: {
            containerView.alphaValue = 0.8
            toVC.view.alphaValue = 1
        })
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let fromVC = fromViewController
        let view = fromVC.view.subviews.first{
            guard let view = $0 as? NXView,
                let userTag = view.userInfo as? Int else {
                return false
            }
            return userTag == containerViewTag
        }
        guard let containerView = view else {
            print("error: ")
            return
        }
        
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        
        NSView.animate(withDuration: 0.5, animations: {
            containerView.alphaValue = 0
            topVC.view.alphaValue = 0
        }) {
            containerView.removeFromSuperview()
            topVC.view.removeFromSuperview()
        }
    }
}

private let containerViewTag: Int = 91

//
//  EmptyTransitionAnimator.swift
//  CustomSegue
//
//  Created by Austin Chen on 2018-09-11.
//

import AppKit

open class EmptyTransitionAnimator: TransitionAnimator {
    open override func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        fromViewController.view.addSubview(viewController.view)
    }
    
    open override func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.removeFromSuperview()
    }
}

//
//  NXNavigationController.swift
//  Custom

//
//  Created by Austin Chen on 2018-09-11.
//

import AppKit

open class NXNavigationController: NSViewController {
    
    open var rootViewController: NSViewController! {
        didSet {
            self.pushViewController(rootViewController, animated: false)
        }
    }
    
    open private(set) var viewControllers: [NSViewController] = []
    
    public convenience init(rootViewController: NSViewController) {
        self.init()
        self.rootViewController = rootViewController
            self.pushViewController(rootViewController, animated: false)
    }

    open func pushViewController(_ viewController: NSViewController, animated: Bool) {
        viewControllers.append(viewController)
        present(viewController,
                              animator: animated ? TransitionAnimator.slideLeftAnimator : TransitionAnimator.emptyAnimator)
    }
    
    open func popViewController(/*animated: Bool*/) -> NSViewController? {
        guard viewControllers.count > 1 else {return nil}
        
        let r = viewControllers.last!
        r.dismiss(nil)
        viewControllers.removeLast()
        
        return r
    }
}

public extension NSViewController {
    open var navigationController: NXNavigationController? {
        return presentingViewController as? NXNavigationController
    }
}

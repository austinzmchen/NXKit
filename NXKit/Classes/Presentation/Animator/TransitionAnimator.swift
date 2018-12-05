//
//  TransitionAnimator.swift
//  CustomSegue
//  Author: Eric Marchand
//  Last edited: Austin Chen

import AppKit

// Simple enum for transition type.
public enum TransitionType {
    case present, dismiss
}

// Protocol that view controllers can implement to receive notification of transition.
// This could be used to change controller behaviours.
public protocol TransitionAnimatorNotifiable {
  
    // Notify the transition completion
    func notifyTransitionCompletion(_ transition: TransitionType)
}

// An animator to present view controller using NSViewControllerTransitionOptions
open class TransitionAnimator: NSObject, NSViewControllerPresentationAnimator {

    // Duration of animation (default: 0.3)
    open var duration: TimeInterval
    // Animation options for view transitions
    open var transition: NSViewController.TransitionOptions
    // Background color used on destination controller if not already defined
    open var backgroundColor = NSColor.windowBackgroundColor
    // If false, destination controller take the size of the source controller
    // If true, when sliding the destination controller keep one of its size element.(ex: for slide down and up, the height is kept)
    // (default: false)
    open var keepOriginalSize = false
    // Remove view of fromViewController from view hierarchy. Best use with crossfade effect.
    open var removeFromView = true
    // Optional origin point for displayed view
    open var origin: NSPoint? = nil {
        didSet {
            assert(keepOriginalSize)
        }
    }
    
    fileprivate var fromView: NSView? = nil

    // Init
    public init(duration: TimeInterval =  0.3, transition: NSViewController.TransitionOptions = [NSViewController.TransitionOptions.crossfade, NSViewController.TransitionOptions.slideDown]) {
        self.duration = duration
        self.transition = transition
    }

    // MARK: NSViewControllerPresentationAnimator
    
    
    @objc open func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let fromFrame = fromViewController.view.frame

        if removeFromView { keepOriginalSize = false } // if animate from view, keepOriginalSize must be off
        let originalFrame = viewController.view.frame
        let startFrame = transition.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
        var destinationFrame = transition.slideStopFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
        
        if let origin = self.origin {
            destinationFrame.origin = origin
        }

        viewController.view.frame = startFrame
        viewController.view.autoresizingMask = [NSView.AutoresizingMask.width, NSView.AutoresizingMask.height]
        
        if transition.contains(NSViewController.TransitionOptions.crossfade) {
            viewController.view.alphaValue = 0
        }

        if !viewController.view.wantsLayer { // remove potential transparency
            viewController.view.wantsLayer = true
            viewController.view.layer?.backgroundColor = backgroundColor.cgColor
            viewController.view.layer?.isOpaque = true
        }
        // maybe create an intermediate container view to remove from controller view from hierarchy
        if removeFromView {
            fromView = fromViewController.view
            fromViewController.view = NSView(frame: fromViewController.view.frame)
            fromViewController.view.addSubview(fromView!)
        }
        fromViewController.view.addSubview(viewController.view)
        
        NSAnimationContext.runAnimationGroup(
            { [unowned self] context in
                context.duration = self.duration
                context.timingFunction =  CAMediaTimingFunction(name: .easeOut)
                
                viewController.view.animator().frame = destinationFrame
                
                if self.transition.contains(NSViewController.TransitionOptions.crossfade) {
                    viewController.view.animator().alphaValue = 1
                }
                
            }, completionHandler: { [unowned self] in
                if self.removeFromView {
                    self.fromView?.removeFromSuperview()
                }
                if let src = viewController as? TransitionAnimatorNotifiable {
                    src.notifyTransitionCompletion(.present)
                }
                if let dst = viewController as? TransitionAnimatorNotifiable {
                    dst.notifyTransitionCompletion(.present)
                }
        })
        
        if removeFromView {
            // let fromViewStartFrame = self.fromView?.frame ?? .zero
            
            NSAnimationContext.runAnimationGroup(
                { [unowned self] context in
                    context.duration = self.duration
                    context.timingFunction =  CAMediaTimingFunction(name: .easeIn)
                    
                    let destFromViewFrame = transition.slideStopFromViewFrame(fromFrame: fromFrame)
                    self.fromView?.animator().frame = destFromViewFrame
                    if self.transition.contains(NSViewController.TransitionOptions.crossfade) {
                        self.fromView?.animator().alphaValue = 0
                    }
                }, completionHandler: { [unowned self] in
                    /*
                    self.fromView?.frame = fromViewStartFrame
                    self.fromView?.alphaValue = 1
                     */
                })
        }
    }

    @objc open func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let fromFrame = fromViewController.view.frame
        let originalFrame = viewController.view.frame
        let destinationFrame = transition.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
        
        if self.removeFromView {
            fromViewController.view.addSubview(self.fromView!)
        }
        
        var ff = destinationFrame
        ff.origin = .zero
        
        NSAnimationContext.runAnimationGroup(
            { [unowned self] context in
                context.duration = self.duration
                context.timingFunction = CAMediaTimingFunction(name: .easeIn)
                
                viewController.view.animator().frame = destinationFrame
                
                if self.transition.contains(NSViewController.TransitionOptions.crossfade) {
                    viewController.view.animator().alphaValue = 0
                }

            }, completionHandler: {
                viewController.view.removeFromSuperview()
                if self.removeFromView {
                    if let view = self.fromView {
                        fromViewController.view = view
                    }
                }
                
                if let src = viewController as? TransitionAnimatorNotifiable {
                    src.notifyTransitionCompletion(.dismiss)
                }
                if let dst = viewController as? TransitionAnimatorNotifiable {
                    dst.notifyTransitionCompletion(.dismiss)
                }
        })
        
        if removeFromView {
            /*
            fromView?.alphaValue = 0
            fromView?.frame = transition.slideStopFromViewFrame(fromFrame: fromFrame)
             */
            
            NSAnimationContext.runAnimationGroup(
                { [unowned self] context in
                    context.duration = self.duration
                    context.timingFunction = CAMediaTimingFunction(name: .easeOut)
                    
                    self.fromView?.animator().frame = ff
                    
                    if self.transition.contains(NSViewController.TransitionOptions.crossfade) {
                        self.fromView?.animator().alphaValue = 1
                    }
                }, completionHandler: {
                })
        }
    }
}


// MARK: NSViewControllerTransitionOptions

extension NSViewController.TransitionOptions {
    
    func slideStartFrame(fromFrame: NSRect, keepOriginalSize: Bool, originalFrame: NSRect) -> NSRect {
        if self.contains(NSViewController.TransitionOptions.slideLeft) {
            let width = keepOriginalSize ? originalFrame.width : fromFrame.width
            return NSRect(x: fromFrame.width, y: 0, width: width, height: fromFrame.height)
        }
        if self.contains(NSViewController.TransitionOptions.slideRight) {
            let width = keepOriginalSize ? originalFrame.width : fromFrame.width
            return NSRect(x: -width, y: 0, width: width, height: fromFrame.height)
        }
        if self.contains(NSViewController.TransitionOptions.slideDown) {
            let height = keepOriginalSize ? originalFrame.height : fromFrame.height
            return NSRect(x: 0, y: fromFrame.height, width: fromFrame.width, height: height)
        }
        if self.contains(NSViewController.TransitionOptions.slideUp) {
            let height = keepOriginalSize ? originalFrame.height : fromFrame.height
            return NSRect(x: 0, y: -height, width: fromFrame.width, height: height)
        }
        if self.contains(NSViewController.TransitionOptions.slideForward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                return NSViewController.TransitionOptions.slideLeft.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            case .rightToLeft:
                return NSViewController.TransitionOptions.slideRight.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            }
        }
        if self.contains(NSViewController.TransitionOptions.slideBackward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                return NSViewController.TransitionOptions.slideRight.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            case .rightToLeft:
                return NSViewController.TransitionOptions.slideLeft.slideStartFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            }
        }
        return fromFrame
    }
    
    func slideStopFrame(fromFrame: NSRect, keepOriginalSize: Bool, originalFrame: NSRect) -> NSRect {
        if !keepOriginalSize {
            return fromFrame
        }
        if self.contains(NSViewController.TransitionOptions.slideLeft) {
            return NSRect(x: fromFrame.width - originalFrame.width , y: 0, width: originalFrame.width , height: fromFrame.height)
        }
        if self.contains(NSViewController.TransitionOptions.slideRight) {
            return NSRect(x: 0, y: 0, width: originalFrame.width , height: fromFrame.height)
        }
        if self.contains(NSViewController.TransitionOptions.slideUp) {
            return NSRect(x: 0, y: 0, width: fromFrame.width, height: originalFrame.height )
        }
        if self.contains(NSViewController.TransitionOptions.slideDown) {
            return NSRect(x: 0, y: fromFrame.height - originalFrame.height , width: fromFrame.width, height: originalFrame.height)
        }
        if self.contains(NSViewController.TransitionOptions.slideForward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                return NSViewController.TransitionOptions.slideLeft.slideStopFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            case .rightToLeft:
                return NSViewController.TransitionOptions.slideRight.slideStopFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            }
        }
        if self.contains(NSViewController.TransitionOptions.slideBackward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                return NSViewController.TransitionOptions.slideRight.slideStopFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            case .rightToLeft:
                return NSViewController.TransitionOptions.slideLeft.slideStopFrame(fromFrame: fromFrame, keepOriginalSize: keepOriginalSize, originalFrame: originalFrame)
            }
        }
        return fromFrame
    }
    
    func slideStopFromViewFrame(fromFrame: NSRect) -> NSRect {
        var ff = fromFrame
        
        if self.contains(NSViewController.TransitionOptions.slideLeft) {
            ff.origin.x = -ff.width / 2
        }
        if self.contains(NSViewController.TransitionOptions.slideRight) {
            ff.origin.x += ff.width / 2
        }
        if self.contains(NSViewController.TransitionOptions.slideUp) {
            ff.origin.y += ff.height / 2
        }
        if self.contains(NSViewController.TransitionOptions.slideDown) {
            ff.origin.y -= ff.height / 2
        }
        if self.contains(NSViewController.TransitionOptions.slideForward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                ff = NSViewController.TransitionOptions.slideLeft.slideStopFromViewFrame(fromFrame:ff)
            case .rightToLeft:
                ff = NSViewController.TransitionOptions.slideRight.slideStopFromViewFrame(fromFrame:ff)
            }
        }
        if self.contains(NSViewController.TransitionOptions.slideBackward) {
            switch NSApp.userInterfaceLayoutDirection {
            case .leftToRight:
                ff = NSViewController.TransitionOptions.slideRight.slideStopFromViewFrame(fromFrame:ff)
            case .rightToLeft:
                ff = NSViewController.TransitionOptions.slideLeft.slideStopFromViewFrame(fromFrame:ff)
            }
        }
        return ff
    }
    
}

// factory 
extension TransitionAnimator {
    
    public static var slideLeftAnimator: TransitionAnimator {
        let ta = TransitionAnimator()
        ta.transition = [.slideLeft]//, .crossfade]
        return ta
    }
    
    public static var slideRightAnimator: TransitionAnimator {
        let ta = TransitionAnimator()
        ta.transition = [.slideRight, .crossfade]
        return ta
    }
    
    public static var slideUpAnimator: TransitionAnimator {
        let ta = TransitionAnimator()
        ta.transition = [.slideUp, .crossfade]
        return ta
    }
    
    public static var slideDownAnimator: TransitionAnimator {
        let ta = TransitionAnimator()
        ta.transition = [.slideDown, .crossfade]
        return ta
    }
    
    public static var emptyAnimator: TransitionAnimator {
        return EmptyTransitionAnimator()
    }
}

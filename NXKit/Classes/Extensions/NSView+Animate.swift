//
//  NSView+Animate.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-28.
//

import AppKit

extension NSView {
    public enum NXTimingFunction {
        case `default`
        case linear
        case easeIn
        case easeOut
        case easeInEaseOut
        
        func toCAMediaTimingFunction() -> CAMediaTimingFunction {
            switch self {
            case .linear: return CAMediaTimingFunction(name: .linear)
            case .easeIn: return CAMediaTimingFunction(name: .easeIn)
            case .easeOut: return CAMediaTimingFunction(name: .easeOut)
            case .easeInEaseOut: return CAMediaTimingFunction(name: .easeInEaseOut)
            default:
                return CAMediaTimingFunction(name: .default)
            }
        }
    }
    
    open class func animate(withDuration duration: TimeInterval,
                            delay: TimeInterval = 0.0,
                            timingFunction: NXTimingFunction = .default,
                            animations: @escaping () -> Void,
                            completion: (() -> Void)? = nil)
    {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = duration
            context.allowsImplicitAnimation = true
            context.timingFunction = timingFunction.toCAMediaTimingFunction()
            animations()
        }, completionHandler: completion)
    }
}

//
//  NSViewPlus.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-15.
//

import AppKit

public extension NSView {
    public var snapshot: NSImage? {
        guard let bitRep = bitmapImageRepForCachingDisplay(in: bounds)
            else { return nil }
        
        bitRep.size = bounds.size
        cacheDisplay(in: bounds, to: bitRep)
        let image = NSImage(size: bounds.size)
        image.addRepresentation(bitRep)
        return image
    }
    
    public func setFirstResponder() {
        window?.makeFirstResponder(self)
    }
    
    /* unlike UIView, iterate subviews and removeFromSuperview causes crash
     https://stackoverflow.com/a/4667694
     Note: Swift's removeAll works swift 4.2+
     */
    public func removeSubviews() {
        subviews = []
    }
}

extension NSView: Focusable {
    @objc public var isFocused: Bool {
        get {
            if let wd = window,
                wd.fieldEditor(false, for: self) == wd.firstResponder {
                return true
            }
            return false
        }

        set {
            window?.makeFirstResponder(self)
        }
    }
}

protocol Focusable {
    var isFocused: Bool {get set}
}

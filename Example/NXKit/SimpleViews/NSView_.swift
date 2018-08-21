//
//  NSView.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-07-31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit

// not working
/*
extension NSView {
    @IBInspectable var backgroundColor: NSColor? {
        set {
            if let newValue = newValue {
                layer?.backgroundColor = newValue.cgColor
                //        drawsBackground = true
            } else {
                //        drawsBackground = false
            }
            
            layer?.cornerRadius = 20
            layer?.masksToBounds = true
            
            layer?.borderColor = NSColor.red.cgColor
            layer?.borderWidth = 2
            layer?.setNeedsDisplay()
        }
        
        get {
            guard let bgColor = layer?.backgroundColor else { return nil }
            return NSColor.init(cgColor: bgColor)
        }
    }
}
 */

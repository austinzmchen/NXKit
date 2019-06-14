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
    
    public func disableInteraction(_ disable: Bool, filter: ( (NSView) -> Bool )? = nil) {
        // This might break the scroll view by disabling some internal view, so don't iterate on the subview property of the scroll view itself.
        if self is NSScrollView {
            return
        }
        else if let selfButton = self as? NSButton {
            (selfButton.cell as? NSButtonCell)?.imageDimsWhenDisabled = false
            selfButton.isEnabled = !disable
            // mouse down/up events are still not disabled
        }
        else {
            subviews.forEach{
                $0.disableInteraction(disable, filter: filter)
            }
            
            if
                (filter == nil || filter != nil && filter!(self)), // if filter exist, then must be true
                let c = self as? NSControl
            {
                c.isEnabled = !disable
            }
        }
    }
}

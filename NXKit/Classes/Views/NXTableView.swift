//
//  NXTableView.swift
//  NXKit
//
//  Created by Austin Chen on 2018-10-29.
//

import AppKit

open class NXTableView: NSTableView, TargetActionable {
    
    @IBInspectable public var accepts1stResponder: Bool = false
    
    open var controlRecords: [NXViewControlRecord] = []
    
    open override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        notifyTargets(.keyDown, event.keyCode)
    }
    
    open override func keyUp(with event: NSEvent) {
        super.keyUp(with: event)
        notifyTargets(.keyUp, event.keyCode)
    }
    
    open override var acceptsFirstResponder: Bool {
        return accepts1stResponder
    }
}

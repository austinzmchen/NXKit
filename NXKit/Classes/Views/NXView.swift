//
//  NXView.swift
//  NXKit
//
//  Created by Austin Chen on 2018-09-06.
//

import AppKit

open class NXView: NSView, Hoverable, BorderStylable, BackgroundStylable, TargetActionable {
    
    // border
    @IBInspectable public var cornerRadius: CGFloat = 0
    @IBInspectable public var borderWidth: CGFloat = 0
    @IBInspectable public var borderColor: NSColor?
    // background
    @IBInspectable public var backgroundColor: NSColor?
    @IBInspectable public var accepts1stResponder: Bool = false
    
    @IBInspectable public var userInteractionEnabled: Bool = true {
        didSet { disableInteraction(!userInteractionEnabled) }
    }
    
    open var userInfo: Any?
    open var controlRecords: [NXViewControlRecord] = []
    
    // MARK: life cycle
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        wantsLayer = true
        
        disableHover()
        enableHover()
    }
    
    open override var wantsUpdateLayer: Bool { return true }
    
    open override func updateLayer() {
        super.updateLayer()
        
        updateBorderStyle()
        updateBackgroundStyle()
    }
    
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

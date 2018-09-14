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
}

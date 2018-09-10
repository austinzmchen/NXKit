//
//  NXView.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-07-31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

open class NXView: NSView {
    // border
    @IBInspectable open var cornerRadius: CGFloat = 0
    @IBInspectable open var borderWidth: CGFloat = 0
    @IBInspectable open var borderColor: NSColor?
    // background
    @IBInspectable open var backgroundColor: NSColor?
    
    open var userInfo: Any?
    open var controlRecords: [NXViewControlRecord] = []
    
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        wantsLayer = true
        
        disableHover()
        enableHover()
    }

    override open var wantsUpdateLayer: Bool { return true }
    
    open override func updateLayer() {
        super.updateLayer()
        
        updateBorderStyle()
        updateBackgroundStyle()
    }
}

extension NXView: Hoverable {}
extension NXView: BorderStylable {}
extension NXView: BackgroundStylable {}

extension NXView: TargetActionable {}

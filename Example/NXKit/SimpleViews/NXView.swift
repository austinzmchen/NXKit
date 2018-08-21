//
//  NXView.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-07-31.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class NXView: NSView {
    // border
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: NSColor = NSColor.clear
    // background
    @IBInspectable public var backgroundColor: NSColor = NSColor.clear
    
    public var controlRecords: [NXViewControlRecord] = []
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        disableHover()
        enableHover()
    }
    
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

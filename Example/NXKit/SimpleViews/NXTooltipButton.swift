//
//  NXTooltipButton.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-22.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

open class NXTooltipButton: NSButton {
    
    public var texts: (normal: String, pressed: String) = (normal: "Text", pressed: "Pressed!")
    
    private var tooltipView = TooltipView()
    private var popupWindow = NSWindow(contentRect: .zero, styleMask: .borderless, backing: .buffered, defer: false)
    
    // MARK: life cycles
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        disableHover()
        enableHover()
        
        // set up popup window
        popupWindow.level = .popUpMenu
        popupWindow.styleMask.remove([.closable, .miniaturizable, .resizable])
        popupWindow.backgroundColor = .clear
        popupWindow.isReleasedWhenClosed = false
        
        tooltipView.translatesAutoresizingMaskIntoConstraints = false
        popupWindow.contentView?.addSubview(tooltipView)
    }
    
    open override func layout() {
        super.layout()
        
        guard let sv = superview,
            let svWindow = sv.window else { return }
        
        var f = frame
        let s = tooltipView.intrinsicContentSize
        f.origin.x += (bounds.width - s.width) / 2.0
        f.origin.y += s.height
        f.size = s // window size match tooltipView
        
        var windowFrame = sv.convert(f, to: nil) // to window's contentView coordinates
        windowFrame = svWindow.convertToScreen(windowFrame) // to window's screen coordinates
        popupWindow.setFrame(windowFrame, display: true)
    }
    
    // MARK: events
    open override func mouseEntered(with event: NSEvent) {
        tooltipView.label.stringValue = texts.normal
        
        tooltipView.invalidateIntrinsicContentSize()
        needsLayout = true
        popupWindow.makeKeyAndOrderFront(nil)
    }
    
    open override func mouseExited(with event: NSEvent) {
        popupWindow.close()
    }
    
    open override func mouseDown(with event: NSEvent) {
        buttonPressed()
        tooltipView.invalidateIntrinsicContentSize()
        needsLayout = true
    }
    
    // MARK: instance methods
    func buttonPressed() {
        tooltipView.label.stringValue = texts.pressed
    }
}

extension NXTooltipButton: Hoverable {
    open override func cursorUpdate(with event: NSEvent) {
        NSCursor.pointingHand.set()
    }
}

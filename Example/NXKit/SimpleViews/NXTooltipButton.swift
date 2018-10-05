//
//  NXTooltipButton.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-22.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

open class NXTooltipButton: NXButton {
    
    public var texts: (normal: String, pressed: String) = (normal: "Text", pressed: "Pressed!")
    
    /// customize popUp frame postion with this additional offset, coordinate postion at bottom left corner
    public var popUpOffset = CGPoint.zero
    
    private var tooltipView: TooltipView?
    private var popupWindow: NSWindow?
    private var noteTokenBag = ACNoteObserverTokenBag()
    
    //------------------------------------------------------------------------
    // MARK: life cycles
    
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        guard let _ = window else {
            popupWindow = nil
            return
        }
        
        disableHover()
        enableHover()
        
        // set up popup window
        tooltipView = TooltipView()
        popupWindow = NSWindow(contentRect: .zero, styleMask: .borderless, backing: .buffered, defer: false)
        popupWindow?.level = .popUpMenu
        popupWindow?.styleMask.remove([.closable, .miniaturizable, .resizable])
        popupWindow?.backgroundColor = .clear
        popupWindow?.isReleasedWhenClosed = false
        
        tooltipView?.translatesAutoresizingMaskIntoConstraints = false
        popupWindow?.contentView?.addSubview(tooltipView!)
        
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace
            .didDeactivateApplicationNotification, object: nil, queue: nil)
        { (note) in
            if let app = note.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                app.localizedName == NSApplication.shared.appName
            {
                self.popupWindow?.close()
            }
        }.addDisposableToken(to: noteTokenBag)
    }

    open override func layout() {
        super.layout()
        
        guard let pw = popupWindow, pw.isVisible,
            let tv = tooltipView,
            let sv = superview,
            let svWindow = sv.window else { return }
        
        var f = frame
        let s = tv.intrinsicContentSize
        f.origin.x += (bounds.width - s.width) / 2.0 + popUpOffset.x
        f.origin.y += s.height + popUpOffset.y
        f.size = s // window size match tooltipView
        
        var windowFrame = sv.convert(f, to: nil) // to window's contentView coordinates
        windowFrame = svWindow.convertToScreen(windowFrame) // to window's screen coordinates
        popupWindow?.setFrame(windowFrame, display: true)
    }
    
    // MARK: events
    open override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        resetPopup()
    }
    
    open override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        resetPopup()
    }
    
    open override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        popupWindow?.close()
    }
    
    open override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        buttonPressed()
        tooltipView?.invalidateIntrinsicContentSize()
        needsLayout = true
    }
}

extension NXTooltipButton {
    private func resetPopup() {
        guard let pw = popupWindow, !pw.isVisible else { return }
        
        tooltipView?.label.stringValue = texts.normal
        tooltipView?.invalidateIntrinsicContentSize()
        needsLayout = true
        popupWindow?.makeKeyAndOrderFront(nil)
    }
    
    // MARK: instance methods
    func buttonPressed() {
        tooltipView?.label.stringValue = texts.pressed
    }
}

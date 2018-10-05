//
//  NXFocusRingView.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-15.
//

import AppKit

public struct NXFocusInfo {
    public var borderWidth: CGFloat
    public var borderColor: NSColor
}

public typealias NXFocusStatesInfo = (on: NXFocusInfo, off: NXFocusInfo)

@IBDesignable
open class NXFocusRingView: NXView {
    
    //------------------------------------------------------------------------
    // MARK: focus setters
    @IBInspectable public var autoHandleFocus: Bool = false
    
    private var _isFocused: Bool = false
    public override var isFocused: Bool {
        get { return _isFocused }
        set {
            _isFocused = newValue
            layer?.setNeedsDisplay()
        }
    }
    public var focusStatesInfo: NXFocusStatesInfo = defaultFocusInfo { didSet {layer?.setNeedsDisplay()} }
    
    //------------------------------------------------------------------------
    // MARK: hover setters
    @IBInspectable public var autoHandleHover: Bool = true
    
    public var isHovering = false {
        didSet { layer?.setNeedsDisplay()}
    }
    
    public var hoverColors: (on: NSColor, off: NSColor) = (on: NSColor.lightGray, off: NSColor.clear) {
        didSet { layer?.setNeedsDisplay()}
    }
    
    public private(set) var hoverAccessaryView: NSView?
    public func set(hoverAccessaryView: NSView?, insets: NSEdgeInsets = NSEdgeInsetsZero) {
        guard let av = hoverAccessaryView else {return}
        self.hoverAccessaryView = av
        
        av.translatesAutoresizingMaskIntoConstraints = false
        addSubview(av)
        av.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        av.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
    }
    
    //------------------------------------------------------------------------
    // MARK: life cycle views
    
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        guard window != nil else {return} // window == nil when view removed
        
        enableHover()
    }
    
    open override var wantsUpdateLayer: Bool { return true }
    
    open override func updateLayer() {
        super.updateLayer()
        
        if isFocused {
            layer?.borderColor = focusStatesInfo.on.borderColor.cgColor
            layer?.borderWidth = focusStatesInfo.on.borderWidth
        } else {
            layer?.borderColor = focusStatesInfo.off.borderColor.cgColor
            layer?.borderWidth = focusStatesInfo.off.borderWidth
        }
        
        if autoHandleHover {
            if isHovering {
                layer?.backgroundColor = hoverColors.on.cgColor
                hoverAccessaryView?.isHidden = false
            } else {
                layer?.backgroundColor = hoverColors.off.cgColor
                hoverAccessaryView?.isHidden = true
            }
        }
    }
    
    // MARK: hover stuff
    open override func mouseEntered(with event: NSEvent) {
        if autoHandleHover {
            notifyTargets(.focused)
            isHovering = true
        }
    }
    
    open override func mouseExited(with event: NSEvent) {
        if autoHandleHover {
            notifyTargets(.unfocused)
            isHovering = false
        }
    }
    
    // MARK: focus ring stuff
    open override var canBecomeKeyView: Bool {
        return autoHandleFocus
    }
    
    open override var acceptsFirstResponder: Bool {
        return autoHandleFocus
    }
    
    open override func becomeFirstResponder() -> Bool {
        isFocused = true
        return super.becomeFirstResponder()
    }
    
    open override func resignFirstResponder() -> Bool {
        isFocused = false
        return super.resignFirstResponder()
    }
}

private let defaultFocusInfo: NXFocusStatesInfo
    = (on: NXFocusInfo.init(borderWidth: 2.5, borderColor: NSColor.blue),
       off: NXFocusInfo.init(borderWidth: 1, borderColor: NSColor.init(red: 169/255.0, green: 167/255.0, blue: 162/255.0, alpha: 1)))

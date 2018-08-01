//
//  NXTextView.swift
//  NXKit
//
//  Created by achen2 on 2018-07-13.
//  Copyright © 2017 TunnelBear. All rights reserved.
//

import AppKit

/* Requires parent 'scrollView' to have
 1. height constraint
 2. width constraint
 */
open class NXTextView: NSTextView {
    
    /*
     NSText's minSize & maxSize are for a different purposes, they contraint the viewable text area's size,
     whereas minScrollSize constaint the scrollView's size
     */
    open var minScrollSize = CGSize.zero
    open var maxScrollSize = CGSize.init(width: CGFloat.infinity, height: CGFloat.infinity)
    @IBInspectable open var respondToTabs: Bool = false // false to allow tabs in text
    
    // misc
    public var controlRecords: [NXViewControlRecord] = []
    private var token: NSObjectProtocol?
    
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        if token != nil { NotificationCenter.default.removeObserver(token!) }
        token = NotificationCenter.default.addObserver(forName: NSText.didChangeNotification, object: self, queue: nil) { [weak self] (note) in
            self?.updateConstraints()
        }
    }
    
    override open func updateConstraints() {
        super.updateConstraints()
        
        let size = self.intrinsicContentSize
        let sv = superview?.superview as? NSScrollView
        sv?.constraints.filter({$0.firstAttribute == .width}).first?.constant = size.width
        sv?.constraints.filter({$0.firstAttribute == .height}).first?.constant = size.height + verticalMargin
    }
    
    override open var intrinsicContentSize: NSSize {
        guard let manager = textContainer?.layoutManager else {
            return .zero
        }
        manager.ensureLayout(for: textContainer!)
        var s =  manager.usedRect(for: textContainer!).size
        s = getValidatedSize(s)
        return s
    }
    
    private func getValidatedSize(_ inputSize: CGSize) -> CGSize {
        var s = inputSize
        
        if s.width < minScrollSize.width { s.width = minScrollSize.width }
        if s.height < minScrollSize.height { s.height = minScrollSize.height }
        
        if s.width > maxScrollSize.width { s.width = maxScrollSize.width }
        if s.height > maxScrollSize.height { s.height = maxScrollSize.height }
        
        return s
    }
}

extension NXTextView: TargetActionable {
    
    override open func becomeFirstResponder() -> Bool {
        notifyTargets(.focused)
        return super.becomeFirstResponder()
    }
    
    override open func resignFirstResponder() -> Bool {
        notifyTargets(.unfocused)
        return super.resignFirstResponder()
    }
}

extension NXTextView {
    open override func insertTab(_ sender: Any?) {
        if respondToTabs { window?.selectNextKeyView(self) }
    }
    
    open override func insertBacktab(_ sender: Any?) {
        if respondToTabs { window?.selectPreviousKeyView(self) }
    }
}

// MARK: storyboard conveniences
extension NXTextView {
    @IBInspectable open var minScrollWidth: CGFloat {
        set { minScrollSize.width = newValue }
        get { return minScrollSize.width }
    }
    @IBInspectable open var minScrollHeight: CGFloat {
        set { minScrollSize.height = newValue }
        get { return minScrollSize.height }
    }
    
    @IBInspectable open var maxScrollWidth: CGFloat {
        set { maxScrollSize.width = newValue }
        get { return minScrollSize.width }
    }
    @IBInspectable open var maxScrollHeight: CGFloat {
        set { maxScrollSize.height = newValue }
        get { return minScrollSize.height }
    }
    
    @IBInspectable open var textInsetWidth: CGFloat {
        set { textContainerInset.width = newValue }
        get { return textContainerInset.width }
    }
    @IBInspectable open var textInsetHeight: CGFloat {
        set { textContainerInset.height = newValue }
        get { return textContainerInset.height }
    }
}

private let verticalMargin: CGFloat = 5 + 5 // top + bottom


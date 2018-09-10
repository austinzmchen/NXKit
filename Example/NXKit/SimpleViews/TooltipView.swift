//
//  ToolTipView.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class TooltipView: NSView, NibLoadable {
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var label: NSTextField!
    
    // MARK: life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        loadNib(name: "TooltipView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.translatesAutoresizingMaskIntoConstraints = false // otherwise window not resizable, weird
        loadNib(name: "TooltipView")
    }
    
    override var intrinsicContentSize: NSSize {
        var s = label.intrinsicContentSize
        s.width += labelEdgeInsets.left + labelEdgeInsets.right
        s.height += labelEdgeInsets.top + labelEdgeInsets.bottom
        
        s.height += pointerHeight
        return s
    }
}

private let labelEdgeInsets: NSEdgeInsets = .init(uniform: 8) // need to match storyboard
private let pointerHeight: CGFloat = 3 // need to match storyboard

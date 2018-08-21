//
//  ToolTipView.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import NXKit

class TooltipView: NSView, NibLoadable {
    @IBOutlet var contentView: NSView!
    
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
}

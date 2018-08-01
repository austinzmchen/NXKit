//
//  BackgroundStylable.swift
//  RememBear
//
//  Created by achen2 on 2018-07-12.
//  Copyright © 2018 TunnelBear. All rights reserved.
//

import AppKit

public protocol BackgroundStylable {
    var backgroundColor: NSColor {get set}
    
    func updateBackgroundStyle()
}

extension BackgroundStylable where Self : NSView {
    public func updateBackgroundStyle() {
        layer?.backgroundColor = backgroundColor.cgColor
    }
}

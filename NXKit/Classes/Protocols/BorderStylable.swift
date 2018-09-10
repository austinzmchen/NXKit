//
//  BorderStylable.swift
//  RememBear
//
//  Created by achen2 on 2018-07-12.
//  Copyright © 2018 TunnelBear. All rights reserved.
//

import AppKit

public protocol BorderStylable {
    var cornerRadius: CGFloat {get set}
    var borderWidth: CGFloat {get set}
    var borderColor: NSColor? {get set}
    
    func updateBorderStyle()
}

extension BorderStylable where Self : NSView {
    public func updateBorderStyle() {
        layer?.cornerRadius = cornerRadius
        layer?.borderWidth = borderWidth
        if let v = borderColor { layer?.borderColor = v.cgColor }
    }
}


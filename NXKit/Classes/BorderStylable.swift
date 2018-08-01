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
    public var cornerRadius: CGFloat {
        set {
            layer?.cornerRadius = newValue
        }
        get { return layer?.cornerRadius ?? 0 }
    }
    
    public var borderWidth: CGFloat {
        set {
            layer?.borderWidth = newValue
        }
        get {
            return layer?.borderWidth ?? 0
        }
    }
    
    public var borderColor: NSColor? {
        set {
            layer?.borderColor = newValue?.cgColor
        }
        get {
            if let c = layer?.borderColor {
                return NSColor(cgColor: c)
            }
            return nil
        }
    }
    
    public func updateBorderStyle() {
        layer?.cornerRadius = cornerRadius
        layer?.borderWidth = borderWidth
        layer?.borderColor = borderColor?.cgColor
    }
}


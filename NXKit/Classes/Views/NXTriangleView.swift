//
//  NXTriangleView.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-21.
//

import AppKit
import Foundation

@IBDesignable
class NXTriangleView: NSView {
    
    @IBInspectable var shapeSize: CGSize = CGSize.zero
    @IBInspectable var shapeColor: NSColor? = nil
    @IBInspectable var strokeColor: NSColor? = nil
    @IBInspectable var strokeWidth: CGFloat = 0
    
    @IBInspectable var shadowColor: NSColor? = nil
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowBlurRadius: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = self.shadowColor
        shadow.shadowOffset = shadowOffset
        shadow.shadowBlurRadius = shadowBlurRadius
        
        //// Bezier Drawing
        let bezierPath = NSBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: shapeSize.height))
        bezierPath.line(to: CGPoint(x: shapeSize.width, y: shapeSize.height))
        
        /* let halfWidth: Float = Float(self.size.width) / 2.0
         let h: Float = powf(halfWidth, 2) -  powf(Float(self.size.height), 2)
         let sq = sqrtf(abs(h)) // pathogorian theorem */
        
        bezierPath.line(to: CGPoint(x: shapeSize.width / 2.0, y: 0))
        bezierPath.line(to: CGPoint(x: 0, y: shapeSize.height))
        bezierPath.close()
        
        shapeColor?.setFill()
        bezierPath.fill()
        
        strokeColor?.setStroke()
        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()
    }
}

//
//  NXGradientView.swift
//  NXKit
//
//  Created by Austin Chen on 2018-10-04.
//

import AppKit

open class NXGradientView: NXView {
    
    public enum GradientDirection {
        case vertical
        case horizontal
        case diagonal
    }
    
    @IBInspectable open var colorA: NSColor?
    @IBInspectable open var colorB: NSColor?
    @IBInspectable open var vertical: Bool = true
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        layer?.addSublayer(l)
        return l
    }()

    /// Set this gradient direction in viewWillAppear or similar, before the view has displayed. Defaults to vertical.
    open var gradientDirection: GradientDirection? {
        didSet { needsDisplay = true }
    }
    
    override open func updateLayer() {
        super.updateLayer()
        guard let layer = layer else { return }
        
        gradientLayer.frame = layer.bounds
        // let gradientDirection override vertical
        if let gd = gradientDirection { // IBOutlet can't show 3 options
            switch gd {
            case .horizontal:
                drawHorizontal()
            case .diagonal:
                drawDiagonal()
            default:
                drawVertical()
            }
        } else {
            if vertical {
                drawVertical()
            } else {
                drawHorizontal()
            }
        }
        
        guard let cA = colorA?.cgColor,
            let cB = colorB?.cgColor else { return }
        
        gradientLayer.colors = [cA, cB]
    }
}

extension NXGradientView {
    func drawVertical() {
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
    }
    
    func drawHorizontal() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // mid left
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // mid right
    }
    
    func drawDiagonal() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
}

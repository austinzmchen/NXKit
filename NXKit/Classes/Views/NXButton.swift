//
//  NXButton.swift
//  NXKit
//
//  Created by Austin Chen on 2018-09-14.
//

import AppKit

open class NXButton: NSButton, Hoverable, BorderStylable, BackgroundStylable, TargetActionable {
    
    @IBInspectable public var userInteractionEnabled: Bool = true
    
    // border
    @IBInspectable public var cornerRadius: CGFloat = 0
    @IBInspectable public var borderWidth: CGFloat = 0
    @IBInspectable public var borderColor: NSColor? = NSColor.clear
    
    // text - use attributedText or can't set textColor other way
    @IBInspectable public var textColor: NSColor? {
        didSet {
            guard let tc = textColor else { return }
            
            let attributedText = NSMutableAttributedString.init(string: title)
            attributedText.setAlignment(alignment, range: .init(location: 0, length: attributedText.length)) // use regular text alignment
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: tc,
                                        range: NSMakeRange(0, title.count))
            attributedTitle = attributedText
        }
    }
    
    // background
    @IBInspectable public var backgroundColor: NSColor? = NSColor.clear
    
    @IBInspectable public var disabledBackgroundColor: NSColor = NSColor.clear {
        didSet {
            setBackgroundColor(disabledBackgroundColor, for: .disabled)
            needsDisplay = true
        }
    }
    
    // hightlighted
    open override var isHighlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var highlightedBackgroundColor: NSColor = NSColor.clear {
        didSet {
            setBackgroundColor(highlightedBackgroundColor, for: .highlighted)
            needsDisplay = true
        }
    }
    
    // state
    private var buttonStates: [(NXButton.State, NSColor)] = []
    func setBackgroundColor(_ color: NSColor, for controlState: NXButton.State) {
        buttonStates.append((controlState, color))
    }
    
    open var controlRecords: [NXViewControlRecord] = []
    
    // MARK: life cycle
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        wantsLayer = true
        
        disableHover()
        enableHover()
    }
    
    open override var wantsUpdateLayer: Bool { return true }
    
    open override func updateLayer() {
        super.updateLayer()
        
        updateBorderStyle()
        updateBackgroundStyle()
        
        func setBgColor(byState state: NXButton.State) {
            buttonStates.forEach{
                if $0.0.contains(state) { layer?.backgroundColor = $0.1.cgColor }
            }
        }
        
        if isHighlighted {
            setBgColor(byState: .highlighted)
        } else if isEnabled {
            setBgColor(byState: .normal)
        } else {
            setBgColor(byState: .disabled)
        }
    }

    override open func mouseDown(with theEvent: NSEvent) {
        super.mouseDown(with: theEvent)
        isHighlighted = true
    }
    
    override open func mouseUp(with theEvent: NSEvent) {
        super.mouseUp(with: theEvent)
        isHighlighted = false
    }
    
    override open func mouseExited(with theEvent: NSEvent) {
        super.mouseExited(with: theEvent)
        isHighlighted = false
    }
}

public extension NXButton {
    
    public struct State : OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let normal = State(rawValue: 1)
        public static let disabled = State(rawValue: 2)
        public static let highlighted = State(rawValue: 4)
    }
}

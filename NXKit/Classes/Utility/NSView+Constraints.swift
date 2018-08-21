//
//  NSView+Constraints.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-15.
//

import AppKit

public enum SnapOption {
    case uniformInset(CGFloat)
    case insets(NSEdgeInsets)
}

private extension SnapOption {
    var resultInsets: NSEdgeInsets {
        switch self {
        case .uniformInset(let n):
            return NSEdgeInsets.init(top: n, left: n, bottom: n, right: n)
        case .insets(let insets):
            return insets
        }
    }
}

public extension NSView {
    
    public func snapTopBottom(toView view: NSView, option: SnapOption = .uniformInset(0)) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: option.resultInsets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -option.resultInsets.bottom)
            ])
    }
    
    public func snapLeadTrail(toView view: NSView, option: SnapOption = .uniformInset(0)) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: option.resultInsets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -option.resultInsets.right)
            ])
    }
    
    public func snapAll(toView view: NSView, option: SnapOption = .uniformInset(0)) {
        snapTopBottom(toView: view, option: option)
        snapLeadTrail(toView: view, option: option)
    }
    
    public func snapTopBottomToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapTopBottom(toView: sv)
    }
    
    public func snapLeadTrailToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapLeadTrail(toView: sv)
    }
    
    public func snapAllToSuperview() {
        snapTopBottomToSuperview()
        snapLeadTrailToSuperview()
    }
}

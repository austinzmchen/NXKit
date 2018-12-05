//
//  NibLoadable.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-21.
//

import AppKit
import NXKit

public protocol NibLoadable {
    var contentView: NSView! {get}
}

public extension NibLoadable where Self: NSView {
    public func loadNib(name: String,
                        bundle: Bundle? = nil,
                        identifier: String? = nil) // pick out main if multiple available
    {
        let loadView: (String) -> (NSView) = { name in
            var topLevelObjects : NSArray?
            let nib = NSNib.init(nibNamed: NSNib.Name.init(name), bundle: bundle)!
            guard nib.instantiate(withOwner: self, topLevelObjects: &topLevelObjects)
                else { fatalError("nib loading error") }
            
            if let id = identifier {
                return topLevelObjects!
                    .first(where: { ($0 as? NSView)?.identifier?.rawValue == id }) as! NSView
            }
            return topLevelObjects!.first(where: { $0 is NSView }) as! NSView
        }
        
        let contentView = loadView(name)
        self.addSubview(contentView)
        
        // add the missing contrainst between xib contentView to self
        // awakeFromNib() is not used, because it is called in loadView function on AppKit
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snapAll(toView: self)
    }
}

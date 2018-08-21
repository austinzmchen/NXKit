//
//  NXFormatter.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-01.
//

import Foundation

/// Like UIKit's UITextFieldDelegate 'shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool'
public class NXTextFormatter: Formatter {
    public var maxLength: Int = Int.max
    public var inclusiveCharset: CharacterSet?
    public var exclusiveCharset: CharacterSet?
    
    public override func isPartialStringValid(_ partialStringPtr: AutoreleasingUnsafeMutablePointer<NSString>,
                                              proposedSelectedRange proposedSelRangePtr: NSRangePointer?,
                                              originalString origString: String, originalSelectedRange origSelRange: NSRange,
                                              errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool
    {
        let str = partialStringPtr.pointee as String
        if str.count > maxLength { return false }
        
        if !str.isEmpty,
            let ic = inclusiveCharset?.inverted, // convert to exclusive
            str.rangeOfCharacter(from: ic) != nil
        {
            return false
        }
        if !str.isEmpty,
            let ec = exclusiveCharset,
            str.rangeOfCharacter(from: ec) != nil
        {
            return false
        }
        
        return true
    }
    
    /* just paying due-deligence asked by Foundation for the method below, otherwise default method raise exceptions  */
    public override func string(for obj: Any?) -> String? {
        return obj as? String
    }
    
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject
        return true
    }
    
    public override func attributedString(for obj: Any, withDefaultAttributes attrs: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString? {
        return nil
    }
}

public extension NXTextFormatter {
    public convenience init(maxLength: Int = Int.max,
                            inclusiveCharset: CharacterSet? = nil,
                            exclusiveCharset: CharacterSet? = nil)
    {
        self.init()
        
        self.maxLength = maxLength
        self.inclusiveCharset = inclusiveCharset
        self.exclusiveCharset = exclusiveCharset
    }
}


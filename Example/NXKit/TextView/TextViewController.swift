//
//  TextViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-01.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class TextViewController: NSViewController {
    
    @IBOutlet weak var textfield1: NSTextField!
    @IBOutlet var textView1: NXTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield1.formatter = NXTextFormatter.init(maxLength: 5,
                                                    inclusiveCharset: CharacterSet.alphanumerics,
                                                    exclusiveCharset: CharacterSet.capitalizedLetters)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        textView1.minScrollSize = CGSize.init(width: 250, height: 100)
        textView1.maxScrollSize = CGSize.init(width: 250, height: view.bounds.height - 100)
        textView1.needsUpdateConstraints = true
        
        
//        view2.layout(basedOn: view.bounds)
    }
}

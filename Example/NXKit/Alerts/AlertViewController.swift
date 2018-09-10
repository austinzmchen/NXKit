//
//  AlertViewController.swift
//  SampleModalSheet
//
//  Created by Austin Chen on 2018-09-08.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import AppKit

class AlertViewController: NSViewController {
    
    @IBAction func alertButtonClicked(_ sender: Any) {
        let alert = NSAlert()
        alert.messageText = "title"
        alert.informativeText = "desc"
        alert.addButton(withTitle: "Ok")
        alert.addButton(withTitle: "Cancel")
        
        let modalResponse = alert.runModal() // blocks like console.readline()
        switch modalResponse {
        case .alertFirstButtonReturn:
            print("Ok")
        case .alertSecondButtonReturn:
            print("Cancel")
        default: break
        }
    }
    
}

//
//  LighthousePresentationSegue.swift
//  SampleModalSheet
//
//  Created by Austin Chen on 2018-09-08.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import AppKit

class LighthousePresentationSegue: NSStoryboardSegue {
    
    override func perform() {
        let animator = LighthousePresentationAnimator()
        let sourceVC  = self.sourceController as! NSViewController
        let destVC = self.destinationController as! NSViewController
        sourceVC.present(destVC, animator: animator)
    }
}

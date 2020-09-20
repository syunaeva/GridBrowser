//
//  GridBrowserWindowController.swift
//  GridBrowser
//
//  Created by Safiya Yunaeva on 19/09/20.
//  Copyright © 2020 Safiya Yunaeva. All rights reserved.
//

import Cocoa

class GridBrowserWindowController: NSWindowController {

    @IBOutlet var addressEntry: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titleVisibility = .hidden
    }

}

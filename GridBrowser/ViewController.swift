//
//  ViewController.swift
//  GridBrowser
//
//  Created by Safiya Yunaeva on 19/09/20.
//  Copyright © 2020 Safiya Yunaeva. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate{
    var rows: NSStackView! // is it a correct way to init variable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create the stack view and add it to our view
        rows = NSStackView()
        rows.orientation = .vertical
        rows.distribution = .fillEqually
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows) //
        
        // 2. Create Auto Layout constraints that pin the stack view to the edges of its container
        rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rows.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rows.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rows.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // 3. Create an initial column that contains a single webview
        let column = NSStackView(views: [makeWebView()])
        column.distribution = .fillEqually
        
        // 4. Add this column to the 'rows' stack view
        rows.addArrangedSubview(column)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func makeWebView() -> NSView {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!)) // try with http - should work
        
        return webView
    }
    @IBAction func urlEntered(_ sender: NSTextField) {
        
    }
    
    @IBAction func navigationClicked(_ sender: NSSegmentedControl) {
        
    }
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        // TODO: add tests to add/delete column + try to add/delete last/fisrt
        // TODO: add step to exit app properly
        
        if sender.selectedSegment == 0 {
            // need to add a column because "+" is selected
            for case let row as NSStackView in rows.arrangedSubviews {
                // loop over each row and add a new webview to it
                row.addArrangedSubview(makeWebView())
                // TODO: there should be a max number of rows like 10?
            }
        } else {
            // need to delete a column
            
            // pull out the first of our rows
            guard let firstRow = rows.arrangedSubviews.first as? NSStackView else { return }
            
            // make sure it has at least two columns
            guard firstRow.arrangedSubviews.count > 1 else { return }
            
            // it is safe to delete a column
            for case let row as NSStackView in rows.arrangedSubviews {
                // loop over every row
                if let last = row.arrangedSubviews.last {
                    // pull out the last webview in this column and remove it using two step process
                    row.removeArrangedSubview(last)
                    last.removeFromSuperview()
                }
            }
        }
    }
}


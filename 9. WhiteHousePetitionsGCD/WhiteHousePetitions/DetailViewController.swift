//
//  DetailViewController.swift
//  WhiteHousePetitions
//
//  Created by Juan Ramírez Blancas on 22/04/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let detailItem = detailItem else {return}
        
        title = detailItem.title
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>body{font-size: 150%;text-align: justify;padding: 5;}</style>
            </head>
            <body>
                \(detailItem.body)
            </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}

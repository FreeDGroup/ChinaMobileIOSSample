//
//  ViewController.swift
//
//  Created by JiWon Yoon on 09/10/2018.
//  Copyright © 2018 JiWon Yoon. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    var widgetButton: UIButton!
    var webView: WKWebView!
    
    @IBAction func toggleButton(_ sender: Any) {
        toggleWidget()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWidet()
    }
    
    func setWidet() {
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "send")
        
        guard let scriptPath = Bundle.main.path(forResource: "widget_script", ofType: "js"),
            let scriptSource = try? String(contentsOfFile: scriptPath) else { return }
        
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userContentController.addUserScript(userScript)
        
        // set WKWebViewConfiguration
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        
        // set WKWebView
        webView = WKWebView(frame: .zero, configuration: config)
        webView.isHidden = true
        
        self.view.addSubview(webView)
        
        // handle constraint
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.9).isActive = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        if let url = URL(string: "https://widget-cm.travelflan.com.cn") {
            webView.load(URLRequest(url: url))
        }
    }
    
    func toggleWidget() {
        if (webView.isHidden) {
            webView.isHidden = false
        } else {
            webView.isHidden = true
        }
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "send", let messageBody = message.body as? String {
            // Define communication with web
        }
    }
}



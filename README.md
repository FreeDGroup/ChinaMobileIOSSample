# [Travelflan](https://www.travelflan.com/) Widget iOS Usage Sample For China-mobile
![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/language%20%7C%20Swift-orange.svg)

## Introduction

We provides the web for chatbot services.
Ultimately, we will recommend using it through the Native sdk.
Until then, we recommend using the webview module in your iOS app.

## Quick Start

1. Insert [widget_script.js](https://github.com/TravelFlanDev/ChinaMobileIOSSample/blob/master/ChinaMobileIOSSample/widget_script.js) source file in your application.
2. Declare and implement your source code refer to the usage below.

## Usage
```
// Declare WKWebview component in your Controller
var webView: WKWebView!

override func viewDidLoad() {
  super.viewDidLoad()
  // call setWidget Method
  setWidet()
}

// Declare setWidget method
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
  // webView.uiDelegate = self
  webView.isHidden = true
  
  self.view.addSubview(webView)
  
  // handle your layout constraint
  webView.translatesAutoresizingMaskIntoConstraints = false
  webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
  webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  webView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
  webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.9).isActive = true
  
  webView.translatesAutoresizingMaskIntoConstraints = false
  
  // This website for china-mobile
  if let url = URL(string: "https://widget-cm.travelflan.com.cn") {
      webView.load(URLRequest(url: url))
  }
}
```

In widget_script.js please refer to the following properties.
```
const initialize = {
  type: 'initialize',
  useEnv: 'iOS',
  openWidget: true, // open widget without open button in web
  provider_id: 12 // for china-mobile
}
```

//
//  ViewController.swift
//  StackOverflowQuestion65270083
//
//  Created by Parker E. Vaughey on 7/23/24.
//
import SwiftUI
import UIKit
import WebKit

struct ViewController: UIViewRepresentable {
    
    class Coordinator: NSObject, WKScriptMessageHandlerWithReply {
        var parent: ViewController
        
        init(_ parent: ViewController) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
            print("Received post message from JavaScript with name: namespaceWithinTheInjectedJSCode")
            
            if message.name == parent.JavaScriptAPIObjectName, let messageBody = message.body as? String {
                
                
                print("namespaceWithinTheInjectedJSCode WkScriptMessage body: \(messageBody)")
                print("Calling replyHandler with 2.2 as the return value and nil as the err string.")
                replyHandler(2.2, nil) // first var is success return val, second is err string if error
            }
        }
    }
    
    var webView: WKWebView?
    let JavaScriptAPIObjectName = "namespaceWithinTheInjectedJSCode"
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let scriptPath = Bundle.main.path(forResource: "script", ofType: "js"),
              let scriptSource = try? String(contentsOfFile: scriptPath, encoding: .utf8) else { return WKWebView() }

        
        
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
    
        userContentController.addUserScript(userScript)
        
        
        // Requires iOS 14
        if #available(iOS 14, *) {
            print("Added addScriptMessageHandler 'namespaceWithinTheInjectedJSCode'")
            userContentController.addScriptMessageHandler(context.coordinator, contentWorld: .page, name: JavaScriptAPIObjectName)
        }
        
        config.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: config)
        
        if let htmlPath = Bundle.main.url(forResource: "page", withExtension: "html") {
            webView.loadFileURL(htmlPath, allowingReadAccessTo: htmlPath)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the view if necessary
    }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        let ucc = uiView.configuration.userContentController
        ucc.removeAllUserScripts()
        ucc.removeScriptMessageHandler(forName: "namespaceWithinTheInjectedJSCode")
    }
}

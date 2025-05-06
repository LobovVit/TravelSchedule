//
//  WebView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI
import WebKit

@MainActor
struct WebView: UIViewRepresentable {
    
    let url: String
    @Binding var state: AgreementState
    @Binding var progress: Double
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: url) {
            let request = URLRequest(url: url, timeoutInterval: 10)
            webView.load(request)
        } else {
            let error = NSError(domain: "", code: NSURLErrorBadURL)
            context.coordinator.handleError(error)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let newURL = URL(string: url), uiView.url != newURL {
            let request = URLRequest(url: newURL, timeoutInterval: 10)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


extension WebView{
    class Coordinator: NSObject, WKNavigationDelegate {
        private var parent: WebView
        private var estimatedProgressObservation: NSKeyValueObservation?
        
        init(_ parent: WebView) {
            self.parent = parent
            super.init()
            self.parent.webView.navigationDelegate = self
            
            estimatedProgressObservation = self.parent.webView.observe(
                \.estimatedProgress,
                 options: [],
                 changeHandler: { [weak self] webView, _ in
                     guard let self = self else { return }
                     self.parent.progress = webView.estimatedProgress
                 })
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.state = .loading
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.state = .success
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            handleError(error)
        }
                
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            handleError(error)
        }
        
        private func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
                    if let response = navigationResponse.response as? HTTPURLResponse,
                       response.statusCode >= 400 {
                        DispatchQueue.main.async {
                            self.parent.progress = 1.0
                            self.parent.state = .error(.serverError)
                        }
                        decisionHandler(.cancel)
                        return
                    }
                    decisionHandler(.allow)
                }
        
        func handleError(_ error: Error) {
            let errorType: AppErrorType
            
            if let nsError = error as NSError? {
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                    errorType = .noInternet
                case NSURLErrorBadURL, NSURLErrorUnsupportedURL:
                    errorType = .invalidURL
                case NSURLErrorTimedOut:
                    errorType = .timeout
                default:
                    errorType = .serverError
                }
            } else {
                errorType = .serverError
            }
            
            DispatchQueue.main.async {
                self.parent.progress = 1.0
                self.parent.state = .error(errorType)
            }
        }
    }
}

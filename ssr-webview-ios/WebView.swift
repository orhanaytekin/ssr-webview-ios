import SwiftUI
import WebKit

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    
    init(_ parent: WebView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView navigation failed: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("WebView provisional navigation failed: \(error.localizedDescription)")
    }
}

struct WebView: UIViewRepresentable {
    let htmlContent: String
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        
        // Add custom user agent to avoid some WebKit restrictions
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Create a temporary file with the HTML content
        if let tempDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let tempFile = tempDir.appendingPathComponent("temp.html")
            
            do {
                try htmlContent.write(to: tempFile, atomically: true, encoding: .utf8)
                let request = URLRequest(url: tempFile)
                webView.load(request)
            } catch {
                print("Failed to write HTML to temporary file: \(error)")
                // Fallback to loadHTMLString
                webView.loadHTMLString(htmlContent, baseURL: Bundle.main.bundleURL)
            }
        }
    }
}

struct WebViewScreen: View {
    let htmlContent: String
    
    var body: some View {
        WebView(htmlContent: htmlContent)
            .edgesIgnoringSafeArea(.all)
    }
} 
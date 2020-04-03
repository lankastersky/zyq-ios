import UIKit
import WebKit

class WebViewController: UIViewController {

    var url: URL?
    var titleString: String?
    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = titleString

        guard let requestUrl = url else {
            assertionFailure("Failed to load url")
            return
        }
        guard let data = try? Data(contentsOf: requestUrl) else {
            assertionFailure("failed to parse description data")
            return
        }
        guard let dataStr = String(data: data, encoding: String.Encoding.utf8) else {
            assertionFailure("failed to convert description to string")
            return
        }
        webView.loadHTMLStringWithMagic(content: dataStr, baseURL: nil)
    }
}

// See https://stackoverflow.com/questions/45998220/the-font-looks-like-smaller-in-wkwebview-than-in-uiwebview
extension WKWebView {

    /// load HTML String same font like the UIWebview
    ///
    //// - Parameters:
    ///   - content: HTML content which we need to load in the webview.
    ///   - baseURL: Content base url. It is optional.
    func loadHTMLStringWithMagic(content:String,baseURL:URL?){
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        loadHTMLString(headerString + content, baseURL: baseURL)
    }
}

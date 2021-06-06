//
//  SafariExtensionHandler.swift
//  yahoo-search-anywhere Extension
//
//  Created by Masakazu on 4/1/21.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

    override func contextMenuItemSelected(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil) {
        let query = (userInfo?["query"] ?? "") as! String
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if command == "YahooSearch" {
            let yahooSearch = "https://search.yahoo.co.jp/search?p=\(encodedQuery)&ei=UTF-8"
            guard let yahooSearchUrl = URL(string: yahooSearch) else { return }
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.openTab(with: yahooSearchUrl, makeActiveIfPossible: true, completionHandler: {_ in
                })
            }
        }
        if command == "YahooImageSearch" {
            let yahooSearch = "https://search.yahoo.co.jp/image/search?p=\(encodedQuery)&ei=UTF-8"
            guard let yahooSearchUrl = URL(string: yahooSearch) else { return }
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.openTab(with: yahooSearchUrl, makeActiveIfPossible: true, completionHandler: {_ in
                })
            }
        }
        if command == "DeepL" {
            let deepL = "https://www.deepl.com/translator#en/ja/\(encodedQuery)"
            guard let deepLUrl = URL(string: deepL) else { return }
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.openTab(with: deepLUrl, makeActiveIfPossible: true, completionHandler: {_ in
                })
            }
        }
    }
}

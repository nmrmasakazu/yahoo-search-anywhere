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
            print("koko")
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
        NSLog("contextMenuItemSelected : Command : \(command), UserInfo : \(String(describing: userInfo))")

        if command == "GoogleImageSearch" {
            let googleSearchUrl = "https://www.google.com/searchbyimage?&image_url=\(userInfo!["imageSrc"])&safe=off";
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.openTab(with: URL(string: googleSearchUrl)!, makeActiveIfPossible: true, completionHandler: {_ in
                    NSLog("Opened google image search url : \(googleSearchUrl)")
                })
            }
        }
    }
}

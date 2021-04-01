//
//  SafariExtensionViewController.swift
//  yahoo-search-anywhere Extension
//
//  Created by Masakazu on 4/1/21.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}

//
//  ShareViewController.swift
//  openIT
//
//  Created by Blydro Klonk on 7/9/18.
//  Copyright © 2018 Blydro Klonk. All rights reserved.
//

import Cocoa

class ShareViewController: NSViewController {
    @IBOutlet weak var boxTitle: NSTextField!
    @IBOutlet weak var errorMessage: NSTextField!
    @IBOutlet weak var errorAcceptButton: NSButton!
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("ShareViewController")
    }

    override func loadView() {
        super.loadView()
    
        // Insert code here to customize the view
        let item = self.extensionContext!.inputItems[0] as! NSExtensionItem
        if let attachments = item.attachments {
            let attachedUrl = (attachments[0] as! NSItemProvider)
            attachedUrl.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (attachedUrl, error) in
                guard let url = attachedUrl as? NSURL else {
                    print(attachedUrl as Any)
                    print("oh no")
                    return
                }
                let browserBundleIdentifier = "org.mozilla.firefox"
                
                NSWorkspace.shared.open([url as URL],
                                        withAppBundleIdentifier:browserBundleIdentifier,
                                        options:[],
                                        additionalEventParamDescriptor:nil,
                                        launchIdentifiers:nil)
                self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
            })
        } else {
            NSLog("No Attachments")
            errorMessage.isHidden = false
            errorAcceptButton.isHidden = false
            
        }
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        let cancelError = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
        self.extensionContext!.cancelRequest(withError: cancelError)
    }

}

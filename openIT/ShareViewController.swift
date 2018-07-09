//
//  ShareViewController.swift
//  openIT
//
//  Created by Miles Grant on 7/9/18.
//  Copyright © 2018 Miles Grant. All rights reserved.
//

import Cocoa

class ShareViewController: NSViewController {

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
                    print(attachedUrl)
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
        }
    }

    @IBAction func send(_ sender: AnyObject?) {
        let outputItem = NSExtensionItem()
        // Complete implementation by setting the appropriate value on the output item
    
        let outputItems = [outputItem]
        self.extensionContext!.completeRequest(returningItems: outputItems, completionHandler: nil)
}

    @IBAction func cancel(_ sender: AnyObject?) {
        let cancelError = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
        self.extensionContext!.cancelRequest(withError: cancelError)
    }

}

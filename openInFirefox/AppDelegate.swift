//
//  AppDelegate.swift
//  openInFirefox
//
//  Created by Blydro Klonk on 7/9/18.
//  Copyright © 2018 Blydro Klonk. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        exit(0) //not a great hack but it works ok
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    


}


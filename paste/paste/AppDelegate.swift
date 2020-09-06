//
//  AppDelegate.swift
//  paste
//
//  Created by loki on 2020/7/31.
//  Copyright © 2020 loki. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var Menu: NSMenu!
    //    var window: NSWindow!
    //create statusbar button
    var eventMonitor: EventMonitor?
    let clipboard =  Clipboard()
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    let popoverView = PopoverViewController()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // 修复按钮单击事件无效问题
        Menu.delegate = self
        // Create the SwiftUI view that provides the window contents.
        if let button = statusItem.button {
            button.image = NSImage(named: "Icon")
            button.action = #selector(mouseClickHandler)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        popover.contentViewController = PopoverViewController.freshController()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
         if let strongSelf = self, strongSelf.popover.isShown {
           strongSelf.closePopover(event!)
         }
        }
        clipboard.startListening()
        clipboard.onNewCopy { (content) in
            self.popoverView.setButtonTitle(content)
            print(content)
          }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    // 控制Popover状态
    @objc func togglePopover(_ sender: AnyObject) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    // 显示Popover
    @objc func showPopover(_ sender: AnyObject) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
        
    }
    // 隐藏Popover
    @objc func closePopover(_ sender: AnyObject) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    @IBAction func exitApp(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    // 接管togglePopover
    @objc func mouseClickHandler() {
        if let event = NSApp.currentEvent {
            switch event.type {
            case .leftMouseUp:
                togglePopover(popover)
            default:
                statusItem.menu = Menu
                statusItem.button?.performClick(nil)
            }
        }
    }
}

extension AppDelegate: NSMenuDelegate {
    // 为了保证按钮的单击事件设置有效，menu要去除
    func menuDidClose(_ menu: NSMenu) {
        self.statusItem.menu = nil
    }
}

//struct AppDelegate_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}

//
//  AppDelegate.swift
//  Snip
//
//  Created by Rainer Selvet on 21/03/2020.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(trigerClick(_:))
            button.target = self
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        popover.contentViewController = JotViewController.freshController()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
          if let strongSelf = self, strongSelf.popover.isShown {
            strongSelf.closePopover(sender: event)
          }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

    @objc func trigerClick(_ sender: NSStatusItem) {
        let event = NSApp.currentEvent!
               
        if event.type == NSEvent.EventType.rightMouseUp {
            let menu = constructMenu();
            menu.popUp(positioning: nil,
                at: NSPoint(x: 0, y: statusItem.statusBar!.thickness),
                in: statusItem.button)
        } else {
           togglePopover(sender)
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
    }

    func showPopover(sender: Any?) {
      if let button = statusItem.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        eventMonitor?.start()
      }
    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
      eventMonitor?.stop()
    }
    
    func constructMenu() -> NSMenu {
      let menu = NSMenu()
        
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit Jot", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

      return menu
    }
}


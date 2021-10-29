//
//  Account_SwitcherApp.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import SwiftUI

@main
struct Account_SwitcherApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 620, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .center)
        }
         .windowStyle(HiddenTitleBarWindowStyle())
        .commands {
            SidebarCommands()
            ToolbarCommands()
        }
    }
}

class AppDelegate: NSResponder, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        NSApp.windows.forEach { $0.standardWindowButton(.zoomButton)?.isEnabled = false }

        NotificationCenter.default.post(Notification(name: Notification.Name("active")))
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        return true
    }
}

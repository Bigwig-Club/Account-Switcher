//
//  AccountSwitcher.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import AppKit

class AccountSwitcher {
    static let shared = AccountSwitcher()
}

extension AccountSwitcher {
    func switchAccount(account: String, password: String) {
        let script = """
        tell application "App Store" to activate
        tell application "System Events" to tell process "App Store"
            set frontmost to true
            if exists sheet 1 of window 1 then
                key code 53
                delay 0.5
            end if
            try
                click last menu item of menu 4 of menu bar 1
            end try
            repeat until exists sheet 1 of window 1
                try
                    click last menu item of menu 4 of menu bar 1
                end try
                delay 0.2
            end repeat
            key code 51
            delay 0.5
            keystroke "\(account)"
            delay 0.5
            keystroke return
            delay 0.5
            keystroke "\(password)"
            delay 0.5
            keystroke return
        end tell
        """
        
        guard  let appleScript = NSAppleScript(source: script) else {
            return
        }
        var errorInfo: NSDictionary? = nil
        appleScript.executeAndReturnError(&errorInfo)
        if errorInfo != nil {
            showErrorAlert()
        }
    }
    
    func showErrorAlert() {
        let alert = NSAlert()
        alert.messageText = "Sorry, some errors occured. :("
        alert.informativeText = "Please try again."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

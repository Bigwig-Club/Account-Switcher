//
//  AccountSwitcher.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import AppKit
import CSV
import Defaults

class Tools {
    static let shared = Tools()
}

// MARK: - switch account

extension Tools {
    func switchAccount(account: String, password: String) {
        let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
        let options = [checkOptPrompt: true]
        let isAppTrusted = AXIsProcessTrustedWithOptions(options as CFDictionary?)
        guard isAppTrusted else {
            return
        }

        let time = 1 / Defaults[.loginSpeed]
        let script = """
        tell application "App Store" to activate
        tell application "System Events" to tell process "App Store"
            set frontmost to true
            try
                click last menu item of menu 4 of menu bar 1
            end try
            repeat until exists sheet 1 of window 1
                try
                    click last menu item of menu 4 of menu bar 1
                end try
                delay 0.1
            end repeat
            delay \(time)
            keystroke "\(account)"
            delay \(time)
            keystroke return
            delay \(time)
            keystroke "\(password)"
            delay \(time)
            keystroke return
        end tell
        """

        guard let appleScript = NSAppleScript(source: script) else {
            return
        }
        var errorInfo: NSDictionary?
        appleScript.executeAndReturnError(&errorInfo)
        if errorInfo != nil {
            showErrorAlert(err: errorInfo as? [String: Any])
        }
    }

    func showErrorAlert(err: [String: Any]?) {
        let alert = NSAlert()
        alert.messageText = (err?["NSAppleScriptErrorMessage"] as? String) ?? "Sorry, some errors occured. :(".localized
        alert.informativeText = "You need to go to「System Preferences > Security and Privacy > Privacy > Automation」to turn on Account Switcher.".localized
        alert.addButton(withTitle: "OK")
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Automation")!)
        }
    }
}

// MARK: - export passwords to csv

extension Tools {
    func exportPasswordsToCsv() {
        let csv = try! CSVWriter(stream: .toMemory())
        let accounts = Defaults[.accounts]

        // Write a row
        try! csv.write(row: ["customName", "account", "password"])

        accounts.forEach { account in
            csv.beginNewRow()
            try! csv.write(field: account.customName)
            try! csv.write(field: account.account)
            try! csv.write(field: account.password)
        }

        csv.stream.close()

        // Get a String
        let csvData = csv.stream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data
        NSSavePanel.saveCsv(csvData) { _ in }
    }
}

// MARK: - import passwords from csv

extension Tools {
    func importPasswordsFromCsv() {
        NSOpenPanel.openCsv { result in
            if case let .success(url) = result, let stream = InputStream(url: url) {
                var newAccounts: [Account] = []

                do {
                    let csv = try! CSVReader(stream: stream, hasHeaderRow: true)

                    let decoder = CSVRowDecoder()
                    while csv.next() != nil {
                        let row = try decoder.decode(Account.self, from: csv)
                        newAccounts.append(row)
                    }

                    let accountsSet = Set(Defaults[.accounts])
                    let all = accountsSet.union(Set(newAccounts))
                    Defaults[.accounts] = Array(all)
                } catch {
                    // Invalid row format
                }
            }
        }
    }
}

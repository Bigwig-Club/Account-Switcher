//
//  FilePanel+Extension.swift
//  AppShot
//
//  Created by Licardo on 2020/7/19.
//  Copyright © 2020 Licardo. All rights reserved.
//

import Cocoa

extension NSOpenPanel {
    static func openCsv(completion: @escaping (_ result: Result<URL, Error>) -> Void) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedFileTypes = ["csv"]
        panel.canChooseFiles = true
        panel.begin { result in
            if result == .OK, let url = panel.urls.first {
                completion(.success(url))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])))
            }
        }
    }
}

extension NSSavePanel {
    static func saveCsv(_ csvData: Data, completion: @escaping (_ result: Result<Bool, Error>) -> Void) {
        let savePanel = NSSavePanel()
        savePanel.title = "Export"
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = "account_switcher.csv"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { result in
            guard result == .OK, let url = savePanel.url else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])))
                return
            }

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try csvData.write(to: url)
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

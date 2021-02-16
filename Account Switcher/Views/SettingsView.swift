//
//  SettingsView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import SwiftUI
import Defaults

struct SettingsView: View {
    @Default(.needAuthToUnlock) var needAuthToUnlock
    @Default(.authSpeed) var authSpeed
    
    var version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Always need authentication to unlock")
                        Toggle(isOn: $needAuthToUnlock) {
                        }
                        .labelsHidden()
                    }
                }
                
                Section {
                    VStack(alignment: .trailing, spacing: 0) {
                        HStack {
                            Text("Authentication speed")
                            Slider(value: $authSpeed, in: 1...5, step: 1) {
                            }
                            .labelsHidden()
                            .frame(width: 150)
                            Text(String(format: "%.0f", authSpeed))
                        }
                        Text("If you can not login successfully, try to slow down the speed")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    
                }
            }
            
            Spacer()
            HStack(spacing: 4) {
                Text("MADE WITH")
                Image("heartFill")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("BY")
                Button {
                    if let url = URL(string: "https://licardo.cn") {
                        NSWorkspace.shared.open(url)
                    }
                } label: {
                    Text("LICARDO")
                }
                .buttonStyle(PlainButtonStyle())
                Text("-")
                Text("v\(version)(\(build))")
            }
            .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  SettingsView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import Defaults
import SwiftUI

struct SettingsView: View {
    @Default(.needAuthToUnlock) var needAuthToUnlock
    @Default(.loginSpeed) var authSpeed

    var version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Always need authentication to unlock")
                    Toggle(isOn: $needAuthToUnlock) {}
                        .labelsHidden()
                }

                VStack(alignment: .trailing, spacing: 0) {
                    HStack {
                        Text("Login speed")
                        Slider(value: $authSpeed, in: 1 ... 5, step: 1) {}
                            .labelsHidden()
                            .frame(width: 150)
                        Text(String(format: "%.0f", authSpeed))
                    }
                    Text("If you CAN NOT login successfully, try to slow down the speed")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Project page")

                    Button {
                        if let url = URL(string: "https://github.com/Bigwig-Club/Account-Switcher") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Text("GitHub")
                            Image("github")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    .frame(width: 80)
                }
                .padding(4)

                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Spacer()
                        Text("MADE WITH")
                        Image("heart")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text("BY LICARDO")
                        Spacer()
                    }

                    Text("v\(version) (\(build))")
                        .font(.system(size: 12))
                }
                .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

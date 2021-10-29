//
//  AccountListCell.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import Defaults
import SwiftUI

struct AccountListCell: View {
    var account: Account
    @Default(.accounts) var accounts
    @State private var showPassword = false
    @State private var showEditAccountSheet = false
    @State private var showAlert = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.customName)
                    .font(.title)
                HStack {
                    Text(account.account)

                    Button {
                        self.showPassword.toggle()
                    } label: {
                        if self.showPassword {
                            Text(account.password)
                        } else {
                            HStack(spacing: 0) {
                                ForEach(0 ..< account.password.count) { _ in
                                    Text("*")
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                HStack {
                    Button {
                        self.showEditAccountSheet.toggle()
                    } label: {
                        Text("Edit")
                    }
                    .buttonStyle(CustomButtonStyle())

                    Button {
                        // self.showAlert.toggle()
                        Tools.shared.switchAccount(account: account.account, password: account.password)
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(CustomButtonStyle())
                }

                Button {
                    accounts.removeAll { $0.account == self.account.account }
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .contextMenu {
            Button {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(account.account, forType: .string)
            } label: {
                Text("Copy Apple ID")
                Image(systemName: "person.crop.circle")
            }

            Button {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(account.password, forType: .string)
            } label: {
                Text("Copy Password")
                Image(systemName: "key")
            }
        }
        .popover(isPresented: $showEditAccountSheet, arrowEdge: .bottom) {
            EditAccountView(selectedAccount: account)
        }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Tips"),
//                          message: Text("""
//                            1. You need to go to "System Preferences > Security and Privacy > Accessibility" to turn on Account Switcher.
//                            2. Do not do any operations during the login process, such as moving the mouse, switching windows, dragging windows, etc.
//                            """),
//                          primaryButton: .default(Text("OK"), action: {
//                            Tools.shared.switchAccount(account: account.account, password: account.password)
//                          }),
//                          secondaryButton: .cancel()
//                    )
//                }
    }
}

struct AccountListCell_Previews: PreviewProvider {
    static let account = Account(customName: "中国 ID", account: "xxx@qq.com", password: "123123")

    static var previews: some View {
        AccountListCell(account: account)
    }
}

//
//  AccountListCell.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import SwiftUI
import Defaults

struct AccountListCell: View {
    var account: Account
    @Default(.accounts) var accounts
    @State private var showPassword = false
    @State private var showEditAccountSheet = false
    
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
                                ForEach(0..<account.password.count) { _ in
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
                    
                    Button {
                        AccountSwitcher.shared.switchAccount(account: account.account, password: account.password)
                    } label: {
                        Text("Login")
                    }
                }
                
                Button {
                    accounts.removeAll {$0.account == self.account.account}
                } label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .popover(isPresented: $showEditAccountSheet, arrowEdge: .bottom) {
            EditAccountView(selectedAccount: account)
        }
    }
}

struct AccountListCell_Previews: PreviewProvider {
    static let account = Account(customName: "中国 ID", account: "1014660822@qq.com", password: "123123")
    
    static var previews: some View {
        AccountListCell(account: account)
    }
}

//
//  PasswordListView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import Defaults
import SwiftUI

struct PasswordListView: View {
    @Default(.accounts) var accounts
    @State private var showAddAccountSheet = false
    @Binding var isUnlocked: Bool

    var body: some View {
        List {
            if accounts.count == 0 {
                Text("Please add an Apple ID")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            } else {
                ForEach(accounts.indices, id: \.self) { index in
                    AccountListCell(account: accounts[index])
                        .padding(.vertical, 6)
                }
                .onMove(perform: moveAccount)
            }
        }
        .sheet(isPresented: $showAddAccountSheet) {
            AddAccountView()
        }
        .toolbar {
            ToolbarItemGroup {
                Spacer()
                
                Button {
                    Tools.shared.importPasswordsFromCsv()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                    Text("Import")
                }

                Button {
                    Tools.shared.exportPasswordsToCsv()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                    Text("Export")
                }

                Button {
                    isUnlocked = false
                } label: {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 15))
                }

                Button {
                    self.showAddAccountSheet.toggle()
                } label: {
                    Image(systemName: "plus.square")
                        .font(.system(size: 15))
                }
            }
        }
    }

    private func moveAccount(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        let movingAccount = accounts[source]
        if source < destination { // 从上往下移动
            accounts.removeAll { $0.account == movingAccount.account }
            accounts.insert(movingAccount, at: destination - 1)
        } else if source > destination { // 从下往上移动
            accounts.removeAll { $0.account == movingAccount.account }
            accounts.insert(movingAccount, at: destination)
        }
    }
}

struct PasswordListView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordListView(isUnlocked: .constant(false))
    }
}

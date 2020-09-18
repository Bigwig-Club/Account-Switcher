//
//  ContentView.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import SwiftUI
import Defaults

struct ContentView: View {
    @Default(.accounts) var accounts
    @State private var showAddAccountSheet = false
    
    var body: some View {
        List {
            Button {
                self.showAddAccountSheet.toggle()
            } label: {
                HStack {
                    Spacer()
                    Image("add")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.primary)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if accounts.count == 0 {
                Text("Please add an account")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            } else {
                ForEach(accounts, id: \.account) { account in
                    AccountListCell(account: account)
                        .padding()
                }
                .onMove(perform: moveAccount)
            }
        }
        .sheet(isPresented: $showAddAccountSheet) {
            AddAccountView()
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 200, idealHeight: 200, maxHeight: .infinity, alignment: .center)
    }
    
    private func moveAccount(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        let account = accounts[source]
        if source < destination { // 从上往下移动
            accounts.removeAll {$0.account == account.account}
            accounts.insert(account, at: destination - 1)
        } else if source > destination { // 从下往上移动
            accounts.removeAll {$0.account == account.account}
            accounts.insert(account, at: destination)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  EditAccountView.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/18.
//

import SwiftUI
import Defaults

struct EditAccountView: View {
    var selectedAccount: Account
    @Default(.accounts) var accounts
    
    @State private var customName = ""
    @State private var account = ""
    @State private var password = ""
    @State private var showAlert = false
    
    @State private var index = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                    Text("Custom Name")
                    TextField("Please enter a custom name", text: $customName)
                }
                HStack {
                    Text("Account")
                    TextField("Please enter Apple ID account", text: $account)
                }
                HStack {
                    Text("Password")
                    TextField("Please enter Apple ID password", text: $password)
                }
            }
            
            HStack(spacing: 100) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    saveAccount()
                } label: {
                    Text("Save")
                }
                .disabled(self.customName.isEmpty || self.account.isEmpty || self.password.isEmpty)
            }
        }
        .frame(width: 300, height: 100, alignment: .center)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Duplicate Account"), message: Text("You have already added this account, please try add another account or edit this one"), dismissButton: .cancel(Text("OK")))
        }
        .onAppear {
            self.customName = selectedAccount.customName
            self.account = selectedAccount.account
            self.password = selectedAccount.password
            self.index = accounts.firstIndex {$0.account == selectedAccount.account} ?? 0
        }
    }
    
    func saveAccount() {
        accounts.removeAll {$0.account == self.selectedAccount.account}
        accounts.insert(Account(customName: self.customName, account: self.account, password: self.password), at: index)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditAccountView_Previews: PreviewProvider {
    static let account = Account(customName: "中国 ID", account: "1014660822@qq.com", password: "123123")
    
    static var previews: some View {
        EditAccountView(selectedAccount: account)
    }
}

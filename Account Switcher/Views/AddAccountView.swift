//
//  AddAccountView.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import SwiftUI
import Defaults

struct AddAccountView: View {
    @Default(.accounts) var accounts
    
    @State private var customName = ""
    @State private var account = ""
    @State private var password = ""
    @State private var showAlert = false
    
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
                    addAccount()
                } label: {
                    Text("Add")
                }
                .disabled(self.customName.isEmpty || self.account.isEmpty || self.password.isEmpty)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Duplicate Account"), message: Text("You have already added this account, please try add another account or edit this one"), dismissButton: .cancel(Text("OK")))
        }
        .frame(width: 300, height: 100, alignment: .center)
        .padding()
    }
    
    func addAccount() {
        if accounts.contains(where: {$0.account == self.account}) {
            self.showAlert.toggle()
        } else {
            accounts.append(Account(customName: self.customName, account: self.account, password: self.password))
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}

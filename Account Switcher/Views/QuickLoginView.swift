//
//  QuickLoginView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/17.
//

import SwiftUI

struct QuickLoginView: View {
    @State private var account = ""
    @State private var password = ""
    
    var body: some View {
        List {
            Form {
                VStack {
                    HStack {
                        Text("Apple ID")
                        TextField("", text: $account)
                    }
                    HStack {
                        Text("Password".localized)
                        TextField("".localized, text: $password)
                    }
                    
                    Button {
                        Tools.shared.switchAccount(account: account, password: password)
                    } label: {
                        Text("Login".localized)
                            .padding(.horizontal)
                    }
                    .buttonStyle(CustomButtonStyle())
                    .disabled(self.account.isEmpty || self.password.isEmpty)
                }
            }
        }
    }
}

struct QuickLoginView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLoginView()
    }
}

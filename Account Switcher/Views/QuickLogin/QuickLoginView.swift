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
        ScrollView {
            VStack {
                HStack {
                    Text("Apple ID")
                    TextField("", text: $account)
                }
                HStack {
                    Text("Password")
                    TextField("", text: $password)
                }

                Button {
                    Tools.shared.switchAccount(account: account, password: password)
                } label: {
                    Text("Login")
                        .padding(.horizontal)
                }
                .buttonStyle(CustomButtonStyle())
                .disabled(self.account.isEmpty || self.password.isEmpty)
            }
            .padding()
        }
    }
}

struct QuickLoginView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLoginView()
    }
}

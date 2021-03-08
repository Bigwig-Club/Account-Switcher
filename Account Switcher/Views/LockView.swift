//
//  LockView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import SwiftUI
import LocalAuthentication
import Defaults

struct LockView: View {
    @Binding var isUnlocked: Bool
    @Default(.needAuthToUnlock) var needAuthToUnlock
    
    var body: some View {
        VStack {
            Image(systemName: "lock.shield")
                .foregroundColor(.red)
                .font(.system(size: 150))
            
            Button {
                if needAuthToUnlock {
                    authenticate()
                } else {
                    isUnlocked = true
                }
            } label: {
                HStack {
                    Image(systemName: "touchid")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                    Text("UNLOCK")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .padding(8)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("active"))) { _ in
            if needAuthToUnlock {
                authenticate()
            } else {
                isUnlocked = true
            }
        }
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please authenticate to unlock."
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView(isUnlocked: .constant(false))
    }
}

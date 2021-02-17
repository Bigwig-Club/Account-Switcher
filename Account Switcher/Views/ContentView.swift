//
//  ContentView.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/16.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false

    var body: some View {
        ZStack {
            if isUnlocked {
                NavigationView {
                    SidebarView(isUnlocked: $isUnlocked)
                        .frame(minWidth: 120, idealWidth: 120, idealHeight: 300, maxHeight: .infinity, alignment: .center)
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button {
                            toggleSidebar()
                        } label: {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
            } else {
                LockView(isUnlocked: $isUnlocked.animation())
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

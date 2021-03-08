//
//  SidebarView.swift
//  AppShot
//
//  Created by Licardo on 2020/7/19.
//  Copyright © 2020 Licardo. All rights reserved.
//

import SwiftUI

struct SidebarView: View {
    @State private var isDefaultItemActive = true
    @Binding var isUnlocked: Bool
    
    var body: some View {
        List {
            NavigationLink(destination: PasswordListView(isUnlocked: $isUnlocked), isActive: $isDefaultItemActive) {
                Label("Password", systemImage: "key")
            }
            
            NavigationLink(destination: QuickLoginView()) {
                Label("Quick Login", systemImage: "bolt")
            }
            
            NavigationLink(destination: SettingsView()) {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(isUnlocked: .constant(true))
    }
}

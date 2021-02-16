//
//  SidebarView.swift
//  AppShot
//
//  Created by Licardo on 2020/7/19.
//  Copyright © 2020 Licardo. All rights reserved.
//

import SwiftUI

struct SidebarView: View {
    @State private var selection: Set<Int> = [0]
    @Binding var isUnlocked: Bool
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(destination: PasswordListView(isUnlocked: $isUnlocked)) {
                Label("Passwords", systemImage: "key")
            }.tag(0)
            
            NavigationLink(destination: SettingsView()) {
                Label("Settings", systemImage: "gearshape")
            }.tag(1)
        }
        .listStyle(SidebarListStyle())
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(isUnlocked: .constant(true))
    }
}

//
//  DefaultKeys.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import Defaults

extension Defaults.Keys {
    static let accounts = Key<[Account]>("accounts", default: [])
    static let needAuthToUnlock = Key<Bool>("needAuthToUnlock", default: true)
    static let authSpeed = Key<Float>("authSpeed", default: 2)
}

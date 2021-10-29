//
//  Account.swift
//  Account Switcher
//
//  Created by Licardo on 2020/9/17.
//

import Defaults
import Foundation

struct Account: Codable, Hashable, DefaultsSerializable {
    var customName: String
    var account: String
    var password: String
}

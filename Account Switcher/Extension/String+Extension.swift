//
//  String+Extension.swift
//  Account Switcher
//
//  Created by Licardo on 2021/2/17.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}

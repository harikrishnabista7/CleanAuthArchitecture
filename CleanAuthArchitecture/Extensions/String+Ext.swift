//
//  String+Ext.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

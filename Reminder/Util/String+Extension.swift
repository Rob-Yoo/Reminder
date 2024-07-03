//
//  String+Extension.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import Foundation

extension String {
    static func *(left: String, right: Int) -> String {
        guard right > 0 else { return "" }
        return String(repeating: left, count: right)
    }
}

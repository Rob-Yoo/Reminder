//
//  OptionType.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import Foundation

enum OptionType {
    case dueDate, tag, priority
    
    var title: String {
        switch self {
        case .dueDate:
            return "마감일"
        case .tag:
            return "태그"
        case .priority:
            return "우선 순위"
        }
    }
}

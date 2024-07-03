//
//  FilterType.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import Foundation

enum FilterType {
    case dueDate
    case title
    case priority
    
    var title: String {
        switch self {
        case .dueDate:
            return "마감일 순으로 보기"
        case .title:
            return "제목 순으로 보기"
        case .priority:
            return "우선순위 순으로 보기"
        }
    }
}

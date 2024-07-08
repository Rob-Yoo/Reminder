//
//  CategoryType.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

enum CategoryType: CaseIterable {
    case Today
    case Schedule
    case Total
    case Flag
    case Complete
    
    var idx: Int {
        switch self {
        case .Today:
            return 0
        case .Schedule:
            return 1
        case .Total:
            return 2
        case .Flag:
            return 3
        case .Complete:
            return 4
        }
    }
    
    var resource: (icon: UIImage?, title: String, bgColor: UIColor) {
        switch self {
        case .Today:
            return (icon: UIImage(systemName: "14.square"), title: "오늘", bgColor: .systemBlue)
        case .Schedule:
            return (icon: UIImage(systemName: "calendar"), title: "예정", bgColor: .systemRed)
        case .Total:
            return (icon: UIImage(systemName: "tray.fill"), title: "전체", bgColor: .systemGray)
        case .Flag:
            return (icon: UIImage(systemName: "flag.fill"), title: "깃발 표시", bgColor: .systemYellow)
        case .Complete:
            return (icon: UIImage(systemName: "checkmark"), title: "완료됨", bgColor: .systemGray)
        }
    }
}

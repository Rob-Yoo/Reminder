//
//  Todo.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import Foundation
import RealmSwift

final class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String
    @Persisted var dueDate: String
    @Persisted var tag: String
    @Persisted var priority: Int
    @Persisted var isComplete: Bool = false
    @Persisted var isFlag: Bool = false

    convenience init(title: String, memo: String, dueDate: String, tag: String, priority: Int) {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority
   }
}

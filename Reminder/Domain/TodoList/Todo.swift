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

    convenience init(title: String, memo: String = "", dueDate: String = "") {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
   }
}

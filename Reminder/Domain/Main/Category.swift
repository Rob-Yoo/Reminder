//
//  Category.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/8/24.
//

import Foundation
import RealmSwift

final class Category: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var todoList = List<Todo>()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}

//
//  TodoBuilder.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import Foundation

final class TodoBuilder {
    private var title: String = ""
    private var memo: String = ""
    private var dueDate: String = ""
    private var tag: String = ""
    private var priority: Int = 0
    
    @discardableResult
    func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult
    func memo(_ memo: String) -> Self {
        self.memo = memo
        return self
    }
    
    @discardableResult
    func dueDate(_ dueDate: String) -> Self {
        self.dueDate = dueDate
        return self
    }
    
    @discardableResult
    func tag(_ tag: String) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func priority(_ priority: Int) -> Self {
        self.priority = priority
        return self
    }
    
    func build() -> Todo {
        return Todo(title: title, memo: memo, dueDate: dueDate, tag: tag, priority: priority)
    }
}

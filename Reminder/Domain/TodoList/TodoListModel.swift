//
//  TodoListModel.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import Foundation
import RealmSwift
import Combine

final class TodoListModel {
    private let realm = try! Realm()
    @Published var todoList: Results<Todo>
    var todoBuilder = TodoBuilder()
    
    init() {
        self.todoList = realm.objects(Todo.self)
    }
    
    func addTodoList(toDo: Todo) {
        try! realm.write {
            realm.add(toDo)
        }
    }
    
    func removeTodoList(primaryKey: ObjectId) {
        try! realm.write {
            guard let todo = realm.object(ofType: Todo.self, forPrimaryKey: primaryKey) else { return }
            
            realm.delete(todo)
        }
    }
    
    func filterTodoList(filterType: FilterType) {
        switch filterType {
        case .dueDate:
            self.todoList = self.todoList.sorted(by: \.dueDate, ascending: true)
        case .title:
            self.todoList = self.todoList.sorted(by: \.title, ascending: true)
        case .priority:
            self.todoList = self.todoList.sorted(by: \.priority, ascending: false)
        }
    }
    
    func updateTodo(value: [String: Any]) {
        try! realm.write {
            realm.create(Todo.self, value: value, update: .modified)
        }
    }
    
    func searchTodoList(searchText: String) {
        let search = realm.objects(Todo.self).where {
            $0.title.contains(searchText, options: .caseInsensitive) || $0.memo.contains(searchText, options: .caseInsensitive)
        }

        self.todoList = searchText.isEmpty ? realm.objects(Todo.self) : search
    }
}

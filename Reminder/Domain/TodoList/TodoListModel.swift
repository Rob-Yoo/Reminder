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
    private var list: List<Todo>
    private var category: Category
   
    @Published var todoList: [Todo]
    var todoBuilder = TodoBuilder()
    
    init(category: Category) {
        self.category = category
        self.list = category.todoList
        self.todoList = list.map { $0 }
    }
    
    func addTodoList(toDo: Todo) {
        do {
            try realm.write {
                list.append(toDo)
            }
            self.reloadData()
        } catch {
            print(error)
        }
    }
    
    func removeTodoList(primaryKey: ObjectId) {
        do {
            try realm.write {
                guard let idx = list.firstIndex(where: { $0.id == primaryKey }), let todo = realm.object(ofType: Todo.self, forPrimaryKey: primaryKey) else {
                    return
                }
                
                self.list.remove(at: idx)
                realm.delete(todo)
            }
            self.reloadData()
        } catch {
            print(error)
        }
    }
    
    func filterTodoList(filterType: FilterType) {
        switch filterType {
        case .dueDate:
            self.todoList = list.sorted(by: \.dueDate, ascending: true).map { $0 }
        case .title:
            self.todoList = list.sorted(by: \.title, ascending: true).map { $0 }
        case .priority:
            self.todoList = list.sorted(by: \.priority, ascending: false).map { $0 }
        }
    }
    
    func updateTodo(value: [String: Any]) {
        do {
            try realm.write {
                realm.create(Todo.self, value: value, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func searchTodoList(searchText: String) {
        let search = self.list.where {
            $0.title.contains(searchText, options: .caseInsensitive) || $0.memo.contains(searchText, options: .caseInsensitive)
        }

        self.todoList = searchText.isEmpty ? list.map { $0 } : search.map { $0 }
    }
    
    private func reloadData() {
        self.todoList = list.map { $0 }
    }
}

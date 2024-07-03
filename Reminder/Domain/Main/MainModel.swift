//
//  MainModel.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import Foundation
import Combine
import RealmSwift

final class MainModel {
    let realm = try! Realm()
    var todoList: Results<Todo> {
        didSet {
            self.totalCount = todoList.count
        }
    }

    @Published var totalCount: Int
    
    init() {
        self.todoList = realm.objects(Todo.self)
        self.totalCount = self.todoList.count
    }
    
    func reloadData() {
        self.todoList = realm.objects(Todo.self)
    }
}

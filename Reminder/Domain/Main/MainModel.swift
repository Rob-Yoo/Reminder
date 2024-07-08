//
//  MainModel.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import Foundation
import RealmSwift

final class MainModel {
    let realm = try! Realm()
    var category: Results<Category>

    init() {
        print(realm.configuration.fileURL)
        self.category = realm.objects(Category.self)
        if category.isEmpty {
            CategoryType.allCases.forEach {
                self.createItem(data: Category(title: $0.resource.title))
            }
        }
    }
    
    func createItem(data: Object) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func reloadData() {
        self.category = realm.objects(Category.self)
    }
}

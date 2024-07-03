//
//  TodoDetailViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

final class TodoDetailViewController: BaseViewController<TodoDetailRootView> {

    private var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.update(todo: self.todo)
    }
}

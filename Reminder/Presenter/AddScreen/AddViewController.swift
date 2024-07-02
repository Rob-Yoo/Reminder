//
//  AddViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit

final class AddViewController: BaseViewController<AddRootView> {

    private let model: TodoListModel
    
    init(contentView: AddRootView, model: TodoListModel) {
        self.model = model
        super.init(contentView: contentView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        
        self.navigationItem.title = "새로운 할 일"
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = addButton
    }

}

//MARK: - User Action Handling
extension AddViewController {
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func addButtonTapped() {
        guard let title = self.contentView.titleTextField.text, let memo = self.contentView.memoTextField.text, let dueDate = self.contentView.dueDateTextField.text else {
            return
        }
        
        if (!title.isEmpty) {
            self.model.addTodoList(title: title, memo: memo, dueDate: dueDate)
            self.dismiss(animated: true)
        }
    }
}

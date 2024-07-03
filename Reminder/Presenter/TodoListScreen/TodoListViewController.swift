//
//  TodoListViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import Combine
import RealmSwift

final class TodoListViewController: BaseViewController<TodoListRootView> {
    
    private let model: TodoListModel
    private var cancellable = Set<AnyCancellable>()
    
    init(model: TodoListModel) {
        self.model = model
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: nil, action: nil)
        
        filterButton.menu = makePullDownMenu()
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    private func makePullDownMenu() -> UIMenu {
        let dueDateAction = UIAction(title: FilterType.dueDate.title) { [weak self] _ in self?.model.filterTodoList(filterType: .dueDate)
        }
        let titleAction = UIAction(title: FilterType.title.title) { [weak self] _ in
            self?.model.filterTodoList(filterType: .title)
        }
        let priorityAction = UIAction(title: FilterType.priority.title) { [weak self] _ in
            self?.model.filterTodoList(filterType: .priority)
        }
        
        return UIMenu(children: [dueDateAction, titleAction, priorityAction])
    }
    
    override func addUserAction() {
        self.contentView.listTableView.delegate = self
        self.contentView.listTableView.dataSource = self
        self.contentView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    override func observeModel() {
        self.model.$todoList
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.listTableView.reloadData()
            }
            .store(in: &cancellable)
        
        self.model.todoList.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.listTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - TableView Delegate/DataSource
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = self.model.todoList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reusableIdentifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(data: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completion in
            let primaryKey = self.model.todoList[indexPath.row].id
            self.model.removeTodoList(primaryKey: primaryKey)
        }
        
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

//MARK: - User Action Handling
extension TodoListViewController {
    @objc private func addButtonTapped() {
        let nextVC = AddViewController(model: self.model)
        let nav = UINavigationController(rootViewController: nextVC)
        
        self.present(nav, animated: true)
    }
}

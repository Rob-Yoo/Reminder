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
        self.contentView.searchBar.delegate = self
    }
    
    override func observeModel() {
        self.model.$todoList
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
        let data = self.model.todoList[indexPath.row]
        let flagImage = (data.isFlag) ? "flag.fill" : "flag"
        
        let detail = UIContextualAction(style: .normal, title: "세부사항") { [weak self] (_, _, _) in
            let nextVC = TodoDetailViewController(todo: data)

            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        let flag = UIContextualAction(style: .normal, title: "깃발") { [weak self] (_, _, _) in
            self?.model.updateTodo(value: ["id": data.id, "isFlag": !data.isFlag], data: data, type: .Flag, isAddToCategory: !data.isFlag)
        }

        let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, _) in
            let primaryKey = data.id
            self?.model.removeTodoList(primaryKey: primaryKey)
        }
        
        detail.backgroundColor = .systemGray
        flag.image = UIImage(systemName: flagImage)
        flag.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [delete, flag, detail])
    }
}

//MARK: - User Action Handling
extension TodoListViewController: TodoListTableViewCellDelegate, UISearchBarDelegate {
    func completeButtonViewTapped(idx: Int) {
        let todo = self.model.todoList[idx]
        guard let cell = self.contentView.listTableView.cellForRow(at: IndexPath(row: idx, section: 0)) as? TodoListTableViewCell else { return }
        
        cell.configureCompleteImage(isComplete: !todo.isComplete)
        self.model.updateTodo(value: ["id": todo.id, "isComplete": !todo.isComplete], data: todo, type: .Complete, isAddToCategory: !todo.isComplete)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.model.searchTodoList(searchText: searchText)
    }
}

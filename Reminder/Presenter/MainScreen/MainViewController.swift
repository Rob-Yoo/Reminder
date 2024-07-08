//
//  MainViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

final class MainViewController: BaseViewController<MainRootView> {

    private let model: MainModel
    
    init(model: MainModel) {
        self.model = model
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.model.reloadData()
        self.contentView.mainCollectionView.reloadData()
    }
    
    private func configureNavigationBar() {
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    override func addUserAction() {
        self.contentView.mainCollectionView.delegate = self
        self.contentView.mainCollectionView.dataSource = self
        self.contentView.addTodoButton.addTarget(self, action: #selector(addTodoButtonTapped), for: .touchUpInside)
    }
}

//MARK: - UICollectionView Delegate/DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = CategoryType.allCases[indexPath.item]
        let count = self.model.category[indexPath.item].todoList.count
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reusableIdentifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(category: category, count: count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.model.category[indexPath.item]
        let nextVC = TodoListViewController(model: TodoListModel(category: category))
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - User Action Handling
extension MainViewController {
    @objc private func addTodoButtonTapped() {
        let idx = CategoryType.Total.idx
        let nextVC = AddViewController(model: TodoListModel(category: self.model.category[idx]))
        let nav = UINavigationController(rootViewController: nextVC)
        
        nextVC.dismissHandler = {
            self.model.reloadData()
            self.contentView.mainCollectionView.reloadData()
        }
        self.present(nav, animated: true)
    }
}

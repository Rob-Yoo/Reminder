//
//  MainViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import Combine

final class MainViewController: BaseViewController<MainRootView> {

    private let model: MainModel
    private var cancellable = Set<AnyCancellable>()
    
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
    
    override func observeModel() {
        self.model.$totalCount
            .receive(on: RunLoop.main)
            .sink { [weak self] count in
                self?.contentView.mainCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - UICollectionView Delegate/DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = Category.allCases[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reusableIdentifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if category == .Total {
            let count = self.model.totalCount
            cell.configureCellData(category: category, count: count)
        } else {
            cell.configureCellData(category: category)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = TodoListViewController(model: TodoListModel())
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - User Action Handling
extension MainViewController {
    @objc private func addTodoButtonTapped() {
        let nextVC = AddViewController(model: TodoListModel())
        let nav = UINavigationController(rootViewController: nextVC)
        
        nextVC.dismissHandler = { self.model.reloadData() }
        self.present(nav, animated: true)
    }
}

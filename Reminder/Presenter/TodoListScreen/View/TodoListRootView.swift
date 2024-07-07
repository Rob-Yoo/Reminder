//
//  TodoListRootView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import SnapKit
import Then

final class TodoListRootView: BaseView {

    private let titleLabel = UILabel().then {
        $0.text = "전체"
        $0.textColor = .systemBlue
        $0.font = .boldSystemFont(ofSize: 35)
    }
    
    let searchBar = UISearchBar().then {
        $0.tintColor = .white
        $0.searchBarStyle = .minimal
        $0.placeholder = "제목이나 메모 내용을 검색해보세요."
        $0.autocapitalizationType = .none
    }
    
    let listTableView = UITableView(frame: .zero, style: .plain).then {
        $0.rowHeight = 80
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reusableIdentifier)
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(searchBar)
        self.addSubview(listTableView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

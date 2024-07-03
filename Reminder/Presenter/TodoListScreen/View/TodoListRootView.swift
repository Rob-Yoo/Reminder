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

    let titleLabel = UILabel().then {
        $0.text = "전체"
        $0.textColor = .systemBlue
        $0.font = .boldSystemFont(ofSize: 35)
    }
    
    let addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    
    let listTableView = UITableView(frame: .zero, style: .plain).then {
        $0.rowHeight = 80
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reusableIdentifier)
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(addButton)
        self.addSubview(listTableView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.size.equalTo(60)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

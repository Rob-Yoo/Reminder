//
//  TodoDetailRootView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class TodoDetailRootView: BaseView {
    
    private let priorityLabel = UILabel().then {
        $0.textColor = .systemBlue
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private let memoLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let dueDateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let tagLabel = UILabel().then {
        $0.textColor = .cyan
        $0.font = .systemFont(ofSize: 12)
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    override func configureHierarchy() {
        self.addSubview(priorityLabel)
        self.addSubview(titleLabel)
        self.addSubview(memoLabel)
        self.addSubview(dueDateLabel)
        self.addSubview(tagLabel)
    }
    
    override func configureLayout() {
        priorityLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dueDateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func update(todo: Todo) {
        self.priorityLabel.text = "!" * todo.priority // 연산자 오버로딩
        self.titleLabel.text = todo.title
        self.memoLabel.text = todo.memo
        self.dueDateLabel.text = todo.dueDate
        self.tagLabel.text = (todo.tag.isEmpty) ? "" : "#" + todo.tag
    }
}

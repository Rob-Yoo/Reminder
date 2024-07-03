//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import SnapKit
import Then

final class TodoListTableViewCell: BaseTableViewCell {
    
    private let circleView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
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

    override func draw(_ rect: CGRect) {
        self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
        self.circleView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(circleView)
        self.contentView.addSubview(priorityLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(memoLabel)
        self.contentView.addSubview(dueDateLabel)
        self.contentView.addSubview(tagLabel)
    }
    
    override func configureLayout() {
        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.size.equalTo(20)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(2)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(50)
        }
        
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(50)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(dueDateLabel.snp.trailing).offset(2)
        }
    }
    
    func configureCellData(data: Todo) {
        self.priorityLabel.text = "!" * data.priority // 연산자 오버로딩
        self.titleLabel.text = data.title
        self.memoLabel.text = data.memo
        self.dueDateLabel.text = data.dueDate
        self.tagLabel.text = (data.tag.isEmpty) ? "" : "#" + data.tag
    }
}

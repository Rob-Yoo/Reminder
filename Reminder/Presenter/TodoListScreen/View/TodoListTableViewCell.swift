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

    override func draw(_ rect: CGRect) {
        self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
        self.circleView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(circleView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(memoLabel)
        self.contentView.addSubview(dueDateLabel)
    }
    
    override func configureLayout() {
        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(50)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
        }
        
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
        }
    }
    
    func configureCellData(data: Todo) {
        self.titleLabel.text = data.title
        self.memoLabel.text = data.memo
        self.dueDateLabel.text = data.dueDate
    }
}

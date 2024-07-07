//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import SnapKit
import Then

protocol TodoListTableViewCellDelegate: AnyObject {
    func completeButtonViewTapped(idx: Int)
}

final class TodoListTableViewCell: BaseTableViewCell {
    
    private lazy var completeButtonView = UIImageView().then {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(completeButtonViewTapped))
        
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tapGR)
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
        self.completeButtonView.layer.cornerRadius = self.completeButtonView.frame.width / 2
        self.completeButtonView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(completeButtonView)
        self.contentView.addSubview(priorityLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(memoLabel)
        self.contentView.addSubview(dueDateLabel)
        self.contentView.addSubview(tagLabel)
    }
    
    override func configureLayout() {
        completeButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.size.equalTo(30)
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
        self.configureCompleteImage(isComplete: data.isComplete)
        self.priorityLabel.text = "!" * data.priority
        self.titleLabel.text = data.title
        self.memoLabel.text = data.memo
        self.dueDateLabel.text = data.dueDate
        self.tagLabel.text = (data.tag.isEmpty) ? "" : "#" + data.tag
    }
    
    func configureCompleteImage(isComplete: Bool) {
        let completeImage = isComplete ? "checkmark.circle" : "circle"
        let tintColor: UIColor = isComplete ? .systemBlue : .lightGray

        self.completeButtonView.image = UIImage(systemName: completeImage)
        self.completeButtonView.tintColor = tintColor
    }
    
    @objc private func completeButtonViewTapped() {
        guard let tableView = superview as? UITableView, let indexPath = tableView.indexPath(for: self) else { return }

        guard let delegate = tableView.delegate as? TodoListTableViewCellDelegate else {
            return
        }
        
        delegate.completeButtonViewTapped(idx: indexPath.row)
    }
}

//
//  TodoOptionView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class TodoOptionView: BaseView {
    private let type: OptionType
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
    }
    
    let contentLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .lightGray
    }
    
    init(type: OptionType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    override func configureView() {
        self.backgroundColor = .customOptionBackground
        self.titleLabel.text = self.type.title
    }
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(arrowImageView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(15)
        }
    }
}

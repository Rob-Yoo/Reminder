//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class MainCollectionViewCell: BaseCollectionViewCell {
    private let iconView = UIImageView().then {
        $0.tintColor = .white
        $0.contentMode = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
    }
    
    override func configureView() {
        self.backgroundColor = .customBackground
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(countLabel)
    }
    
    override func configureLayout() {
        iconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(iconView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.iconView.layer.cornerRadius = self.iconView.frame.width / 2
        self.iconView.clipsToBounds = true
    }
    
    func configureCellData(category: Category, count: Int = 0) {
        let resource = category.resource

        self.iconView.image = resource.icon
        self.iconView.backgroundColor = resource.bgColor
        self.titleLabel.text = resource.title
        self.countLabel.text = count.formatted()
    }
}

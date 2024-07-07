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
    
    lazy var contentLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 15)
    }
    
    lazy var contentImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
    
    private func configureTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureLayout() {
        let content = (self.type == .image) ? contentImage : contentLabel
        
        self.configureTitleLabel()
        self.configureArrowImageView()
        self.configureContent(content: content)
    }
    
    private func configureArrowImageView() {
        self.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(15)
        }
    }
    
    private func configureContent(content: UIView) {
        self.addSubview(content)
        
        content.snp.makeConstraints { make in
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-10)
            make.verticalEdges.equalToSuperview().inset(5)
            
            if (self.type == .image) {
                make.width.equalTo(content.snp.height)
            }
        }
    }
    
}

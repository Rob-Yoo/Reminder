//
//  TagView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class TagView: BaseView {
    let tagTextField = UITextField().then {
        $0.placeholder = "태그 입력"
        $0.textColor = .white
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 2
    }
    
    override func configureView() {
        self.backgroundColor = .customBackground
    }
    
    override func configureHierarchy() {
        self.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}

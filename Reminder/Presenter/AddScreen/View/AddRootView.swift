//
//  AddRootView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import SnapKit
import Then

final class AddRootView: BaseView {
    
    let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.textColor = .white
        $0.borderStyle = .line
    }
    
    let memoTextField = UITextField().then {
        $0.placeholder = "메모"
        $0.textColor = .white
        $0.borderStyle = .line
    }
    
    let dueDateTextField = UITextField().then {
        $0.placeholder = "마감일"
        $0.textColor = .white
        $0.borderStyle = .line
    }
    
    override func configureView() {
        self.backgroundColor = .customBackground
    }
    
    override func configureHierarchy() {
        self.addSubview(titleTextField)
        self.addSubview(memoTextField)
        self.addSubview(dueDateTextField)
    }

    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        dueDateTextField.snp.makeConstraints { make in
            make.top.equalTo(memoTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}

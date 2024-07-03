//
//  DueDateView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class DueDateView: BaseView {
    
    let dueDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    override func configureView() {
        self.backgroundColor = .customBackground
    }
    
    override func configureHierarchy() {
        self.addSubview(dueDatePicker)
    }
    
    override func configureLayout() {
        dueDatePicker.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
}

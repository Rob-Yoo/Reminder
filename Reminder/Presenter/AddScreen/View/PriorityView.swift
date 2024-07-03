//
//  PriorityView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class PriorityView: BaseView {
    
    let prioritySegmentedControl = UISegmentedControl(items: ["낮음", "중간", "높음"]).then {
        $0.selectedSegmentIndex = 1
    }
    
    override func configureView() {
        self.backgroundColor = .customBackground
    }
    
    override func configureHierarchy() {
        self.addSubview(prioritySegmentedControl)
    }
    
    override func configureLayout() {
        prioritySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

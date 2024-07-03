//
//  BaseCollectionViewCell.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        self.configureHierarchy()
        self.configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {}
    func configureHierarchy() {}
    func configureLayout() {}
}

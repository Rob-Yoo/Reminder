//
//  MainRootView.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit
import SnapKit
import Then

final class MainRootView: BaseView {
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reusableIdentifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    let addTodoButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.setTitle(" 새로운 할 일", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.tintColor = .systemBlue
    }
    
    private let addListLabel = UILabel().then {
        $0.text = "목록 추가"
        $0.textColor = .systemBlue
        $0.font = .systemFont(ofSize: 18)
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 25) / 2
        let height = width * 0.5
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return layout
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    override func configureHierarchy() {
        self.addSubview(mainCollectionView)
        self.addSubview(addTodoButton)
        self.addSubview(addListLabel)
    }
    
    override func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-50)
        }
        
        addTodoButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(addTodoButton.snp.width).multipliedBy(0.2)
        }
        
        addListLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}

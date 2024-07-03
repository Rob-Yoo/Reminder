//
//  BaseViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit

class BaseViewController<ContentView: UIView>: UIViewController {
    
    let contentView: ContentView
    
    init(contentView: ContentView = ContentView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserAction()
        self.observeModel()
    }
    
    func addUserAction() {}
    func observeModel() {}
}

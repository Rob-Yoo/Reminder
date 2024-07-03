//
//  TagViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

final class TagViewController: BaseViewController<TagView> {

    var passTag: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let tag = self.contentView.tagTextField.text else { return }
        passTag?(tag)
    }
}

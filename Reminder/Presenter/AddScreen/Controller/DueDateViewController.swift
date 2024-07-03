//
//  DueDateViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

final class DueDateViewController: BaseViewController<DueDateView> {

    var passDueDate: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let dateFormatter = DateFormatter()
        let date = self.contentView.dueDatePicker.date
        let dateString: String

        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateString = dateFormatter.string(from: date)
        passDueDate?(dateString)
    }
}

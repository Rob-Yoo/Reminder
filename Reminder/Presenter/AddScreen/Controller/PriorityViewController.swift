//
//  PriorityViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/3/24.
//

import UIKit

final class PriorityViewController: BaseViewController<PriorityView> {

    var passPriority: ((Int, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let selectedIdx = self.contentView.prioritySegmentedControl.selectedSegmentIndex
        let priority = selectedIdx + 1
        guard let text = self.contentView.prioritySegmentedControl.titleForSegment(at: selectedIdx) else { return }
        
        passPriority?(priority, text)
    }
}

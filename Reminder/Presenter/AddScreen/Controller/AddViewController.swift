//
//  AddViewController.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit
import Toast
import PhotosUI

final class AddViewController: BaseViewController<AddRootView> {

    private let model: TodoListModel
    
    var dismissHandler: (() -> Void)?
    
    init(model: TodoListModel) {
        self.model = model
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }

    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        
        self.navigationItem.title = "새로운 할 일"
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func addUserAction() {
        let dueDateTapGR = UITapGestureRecognizer(target: self, action: #selector(dueDateOptionViewTapped))
        let tagTapGR = UITapGestureRecognizer(target: self, action: #selector(tagOptionViewTapped))
        let priorityTapGR = UITapGestureRecognizer(target: self, action: #selector(priorityOptionViewTapped))
        let imageTapGR = UITapGestureRecognizer(target: self, action: #selector(imageOptionViewTapped))
        
        self.contentView.dueDateOptionView.addGestureRecognizer(dueDateTapGR)
        self.contentView.tagOptionView.addGestureRecognizer(tagTapGR)
        self.contentView.priorityOptionView.addGestureRecognizer(priorityTapGR)
        self.contentView.imageOptionView.addGestureRecognizer(imageTapGR)
    }

}

//MARK: - User Action Handling
extension AddViewController {
    @objc private func cancelButtonTapped() {
        dismissHandler?()
        self.dismiss(animated: true)
    }
    
    @objc private func addButtonTapped() {
        guard let title = self.contentView.titleTextField.text, let memo = self.contentView.memoTextField.text else {
            return
        }
        
        if (!title.isEmpty) {
            let newTodo = self.model.todoBuilder.title(title).memo(memo).build()

            self.model.addTodoList(toDo: newTodo)
            if let image = self.contentView.imageOptionView.contentImage.image {
                self.saveImageToDocument(image: image, filename: "\(newTodo.id)")
            }
            dismissHandler?()
            self.dismiss(animated: true)
        } else {
            self.contentView.makeToast("제목을 입력해주세요!", duration: 1.0, position: .center)
        }
    }
    
    @objc private func dueDateOptionViewTapped() {
        let nextVC = DueDateViewController()
        
        nextVC.passDueDate = {
            self.contentView.dueDateOptionView.contentLabel.text = $0
            self.model.todoBuilder.dueDate($0)
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func tagOptionViewTapped() {
        let nextVC = TagViewController()
        
        nextVC.passTag = {
            self.contentView.tagOptionView.contentLabel.text = (!$0.isEmpty) ? "#" + $0 : ""
            self.model.todoBuilder.tag($0)
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func priorityOptionViewTapped() {
        let nextVC = PriorityViewController()
        
        nextVC.passPriority = { priority, text in
            self.contentView.priorityOptionView.contentLabel.text = text
            self.model.todoBuilder.priority(priority)
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc private func imageOptionViewTapped() {
        var config = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: config)
        
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) {
                    image, error in
                    DispatchQueue.main.async {
                        self.contentView.imageOptionView.contentImage.image = image as? UIImage
                        picker.dismiss(animated: true)
                    }
                }
            }
        }
    }
}

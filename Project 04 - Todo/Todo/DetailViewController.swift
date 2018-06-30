//
//  DetailViewController.swift
//  Todo
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func didSave(todo: ToDoItem)
}

class DetailViewController: UIViewController {
    
    // MARK: - Data
    
    var todo: ToDoItem?
    private var selectedIndex: Int = 0
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - Views
    var detailView: DetailToDoView!
    
    // MARK: - Life cycle
    
    override func loadView() {
        detailView = DetailToDoView()
        
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        updateView()
    }
    
    func updateView() {
        if let todo = todo {
            selectedIndex = ToDoCategory.allCategories.index(of: todo.category)!
            detailView.datePicker.date = todo.dueDate
        }
        
        detailView.textField.text = todo?.title
        detailView.categoryButtons[selectedIndex].isSelected = true
    }
    
    @objc func categoryButtonPressed(_ button: UIButton) {
        resetCategoryButtonsState()
        button.isSelected = true
        selectedIndex = detailView.categoryButtons.index(of: button)!
    }
    
    @objc func saveButtonPressed() {
        guard let title = detailView.textField.text, !title.isEmpty else {
            return
        }
        
        let category = ToDoCategory.allCategories[selectedIndex]
        let dueDate = detailView.datePicker.date
        let todo = ToDoItem(title: title, category: category, dueDate: dueDate)
        delegate?.didSave(todo: todo)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private helpers
    
    private func setUpView() {
        detailView.categoryButtons.forEach { (button) in
            button.addTarget(self, action: #selector(DetailViewController.categoryButtonPressed(_:)), for: .touchUpInside)
        }
        
        detailView.saveButton.addTarget(self, action: #selector(DetailViewController.saveButtonPressed), for: .touchUpInside)
    }
    
    private func resetCategoryButtonsState() {
        detailView.categoryButtons.forEach { (button) in
            button.isSelected = false
        }
    }
}

//
//  DetailToDoView.swift
//  Todo
//
//  Created by Doan Le Thieu on 6/29/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import UIKit

class DetailToDoView: UIView {
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40
        
        return stackView
    }()
    
    
    lazy var categoryButtons: [UIButton] = ToDoCategory.allCategories.map { makeCategoryButton($0) }
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        return datePicker
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        backgroundColor = .white
        
        // content view
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 28),
            contentView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -28)])
        
        if #available(iOS 11.0, *) {
            let safeArea = safeAreaLayoutGuide
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        } else {
            // Fallback on earlier versions
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 64).isActive = true
        }
        
        // category buttons
        categoryButtons.forEach { (button) in
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        }
        
        // create a horizontal stack view to contain all category buttons
        let buttonStack = UIStackView(arrangedSubviews: categoryButtons)
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        buttonStack.alignment = .fill
        
        contentView.addArrangedSubview(buttonStack)
        
        // label for text field
        let label = UILabel()
        label.text = "Title"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let textFieldContainer = UIStackView(arrangedSubviews: [label, textField])
        textFieldContainer.axis = .horizontal
        textFieldContainer.distribution = .fill
        textFieldContainer.alignment = .fill
        textFieldContainer.spacing = 20
        
        contentView.addArrangedSubview(textFieldContainer)
        
        // date picker
        contentView.addArrangedSubview(datePicker)
        
        // save button
        contentView.addArrangedSubview(saveButton)
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // add tap gesture
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailToDoView.dismissTextField))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissTextField() {
        textField.resignFirstResponder()
    }
    
    private func makeCategoryButton(_ category: ToDoCategory) -> UIButton {
        let button = UIButton()
        
        button.setImage(UIImage(category: category, selected: false), for: .normal)
        button.setImage(UIImage(category: category), for: .selected)
        
        return button
    }
}

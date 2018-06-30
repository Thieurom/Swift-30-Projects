//
//  ViewController.swift
//  Todo
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Data
    
    var todoStore: ToDoStore!
    private let cellId = "ToDoCellId"
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        todoStore.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: true)
    }
    
    @objc func addBarButtonPressed() {
        showDetailViewController(for: nil)
    }
    
    // MARK: - Private helpers
    
    private func setUpView() {
        // navigation bar
        navigationItem.title = "Todo List"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addBarButtonPressed))

        // add table view to view's hierarchy
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        // setup table view
        tableView.register(ToDoCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureCell(_ cell: ToDoCell, at indexPath: IndexPath) {
        guard let todoItem = todoStore.todo(at: indexPath.row) else {
            return
        }
        
        cell.textLabel?.text = todoItem.title
        cell.detailTextLabel?.text = todoItem.dueDate.toString(dateFormat: "yyyy-MM-dd")
        cell.imageView?.image = UIImage(category: todoItem.category)
    }
    
    private func showDetailViewController(for todo: ToDoItem? = nil) {
        let detailViewController = DetailViewController()
        
        detailViewController.todo = todo
        detailViewController.title = todo == nil ? "New Todo" : "Edit Todo"
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// ========================================================================================================

// MARK: - UITableView Data Source

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoStore.todoCount > 0 {
            return todoStore.todoCount
        } else {
            let messageLabel = UILabel()
            messageLabel.font = UIFont.systemFont(ofSize: 20)
            messageLabel.textAlignment = .center
            messageLabel.text = "Empty list"
            
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ToDoCell else {
            fatalError("Failed to dequeue cell")
        }
        
        configureCell(cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoStore.removeTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todoStore.moveTodo(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}

// MARK: - UITableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todo = todoStore.todo(at: indexPath.row) else {
            return
        }
        
        showDetailViewController(for: todo)
    }
}

// MARK: - DetailViewController Delegate

extension ViewController: DetailViewControllerDelegate {
    
    func didSave(todo: ToDoItem) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            todoStore.updateTodo(todo, at: selectedIndexPath.row)
        } else {
            todoStore.addTodo(todo)
        }
    }
}

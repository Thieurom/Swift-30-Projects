//
//  ToDoStore.swift
//  Todo
//
//  Created by Doan Le Thieu on 6/29/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import Foundation

class ToDoStore {
    
    private var todoList = [ToDoItem]()
    
    var todoCount: Int {
        return todoList.count
    }
    
    func load() {
        let now = Date()
        let secondsOfDay = 24 * 60 * 60
        
        let todoItemOne = ToDoItem(title: "Go to Disney", category: .kid, dueDate: now)
        let todoItemTwo = ToDoItem(title: "Cisco Shopping", category: .shopping, dueDate: Date(timeInterval: TimeInterval(secondsOfDay), since: now))
        let todoItemThree = ToDoItem(title: "Phone to Jobs", category: .phone, dueDate: Date(timeInterval: TimeInterval(secondsOfDay * 2), since: now))
        let todoItemFour = ToDoItem(title: "Plan to Europe", category: .travel, dueDate: Date(timeInterval: TimeInterval(secondsOfDay * 3), since: now))
        
        todoList.append(contentsOf: [todoItemOne, todoItemTwo, todoItemThree, todoItemFour])
    }
    
    func addTodo(_ todo: ToDoItem) {
        todoList.append(todo)
    }
    
    func todo(at index: Int) -> ToDoItem? {
        guard index >= 0 && index < todoCount else {
            return nil
        }
        
        return todoList[index]
    }
    
    func moveTodo(fromIndex: Int, toIndex: Int) {
        guard fromIndex >= 0 && fromIndex < todoCount && toIndex >= 0 && toIndex < todoCount && fromIndex != toIndex else {
            return
        }
        
        let movedTodo = todoList.remove(at: fromIndex)
        todoList.insert(movedTodo, at: toIndex)
    }
    
    func updateTodo(_ todo: ToDoItem, at index: Int) {
        todoList[index] = todo
    }
    
    func removeTodo(at index: Int) {
        todoList.remove(at: index)
    }
}

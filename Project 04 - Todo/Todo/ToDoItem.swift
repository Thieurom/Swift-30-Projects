//
//  ToDoItem.swift
//  Todo
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

enum ToDoCategory {
    case kid
    case shopping
    case phone
    case travel
    
    static var allCategories: [ToDoCategory] {
        return [.kid, .shopping, .phone, .travel]
    }
}

struct ToDoItem {
    var title: String
    var category: ToDoCategory
    var dueDate: Date
    
    init(title: String, category: ToDoCategory, dueDate: Date) {
        self.title = title
        self.category = category
        self.dueDate = dueDate
    }
}

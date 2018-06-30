//
//  UIImage+Cagegory.swift
//  Todo
//
//  Created by Doan Le Thieu on 6/29/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(category: ToDoCategory, selected: Bool = true) {
        if selected {
            switch category {
            case .kid: self.init(named: "child-selected")
            case .shopping: self.init(named: "shopping-cart-selected")
            case .phone: self.init(named: "phone-selected")
            case .travel: self.init(named: "travel-selected")
            }
        } else {
            switch category {
            case .kid: self.init(named: "child")
            case .shopping: self.init(named: "shopping-cart")
            case .phone: self.init(named: "phone")
            case .travel: self.init(named: "travel")
            }
        }
    }
}

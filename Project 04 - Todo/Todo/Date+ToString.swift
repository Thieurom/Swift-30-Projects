//
//  Date+ToString.swift
//  Todo
//
//  Created by Doan Le Thieu on 6/30/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}

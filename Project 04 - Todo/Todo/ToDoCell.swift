//
//  ToDoCell.swift
//  Todo
//
//  Created by Doan Le Thieu on 6/29/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

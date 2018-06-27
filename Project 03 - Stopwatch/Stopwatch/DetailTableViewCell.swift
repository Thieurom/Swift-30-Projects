//
//  DetailTableViewCell.swift
//  Stopwatch
//
//  Created by Doan Le Thieu on 6/27/18.
//  Copyright © 2018 YiGu. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
        
        backgroundColor = .black
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

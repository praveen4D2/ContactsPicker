//
//  TableViewCell.swift
//  ContactsPicker
//
//  Created by Adaps on 04/12/19.
//  Copyright © 2019 CrazyTricks. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var item: Any?{
        didSet{
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?){}

}

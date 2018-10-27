//
//  TableViewCompatible.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

protocol TableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
}

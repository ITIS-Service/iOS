//
//  AnswersDatasource.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 28/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class AnswersDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data = [TableViewCompatible]()
    var onTap: ((IndexPath) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        return model.cell(for: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTap?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66;
    }
    
}

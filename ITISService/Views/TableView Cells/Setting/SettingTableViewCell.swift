//
//  SettingTableViewCell.swift
//  ITISService
//
//  Created by Timur Shafigullin on 06/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell, Configurable {
    typealias T = Settings.TableView.Model
    
    // MARK: - Instance Properties
    
    var model: Settings.TableView.Model?
    
    // MARK: - Instance Methods
    
    func configure(with model: Settings.TableView.Model) {
        self.textLabel?.text = model.settingName
    }
}

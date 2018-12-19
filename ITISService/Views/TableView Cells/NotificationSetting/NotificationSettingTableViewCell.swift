//
//  NotificationSettingTableViewCell.swift
//  ITISService
//
//  Created by Timur Shafigullin on 19/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class NotificationSettingTableViewCell: UITableViewCell, Configurable {
    
    typealias T = NotificationSettings.TableView.Model
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var settingSwitch: UISwitch!
    
    // MARK: -
    
    var model: NotificationSettings.TableView.Model?
    
    // MARK: - Instance Methods
    
    @IBAction fileprivate func onSettingSwitchValueChanged(_ sender: UISwitch) {
        self.model?.onSwitchValueChanged?(sender.isOn)
    }
    
    // MARK: -
    
    func configure(with model: NotificationSettings.TableView.Model) {
        self.model = model
        self.titleLabel.text = model.title
    }
    
}

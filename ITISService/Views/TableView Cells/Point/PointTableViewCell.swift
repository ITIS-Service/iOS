//
//  PointTableViewCell.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class PointTableViewCell: UITableViewCell, Configurable {
    
    typealias T = Points.TableView.Model
    
    // MARK: - Instance properties
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var pointLabel: UILabel!
    
    // MARK: -
    
    var model: Points.TableView.Model?
    
    // MARK: - Instance Methods
    
    func configure(with model: Points.TableView.Model) {
        self.model = model
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.pointLabel.text = model.count > 0 ? "+\(model.count)" : "\(model.count)"
    }
    
}

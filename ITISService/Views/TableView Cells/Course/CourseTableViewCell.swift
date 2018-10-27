//
//  CourseTableViewCell.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell, Configurable {
    
    typealias T = Courses.TableView.Model
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var model: Courses.TableView.Model?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 92 / 255.0, green: 92 / 255.0, blue: 92 / 255.0, alpha: 1)
        self.selectedBackgroundView = selectedView
    }
    
    func configure(with model: Courses.TableView.Model) {
        self.model = model
        self.titleLabel.text = model.name
        self.descriptionLabel.text = model.description
    }
    
}

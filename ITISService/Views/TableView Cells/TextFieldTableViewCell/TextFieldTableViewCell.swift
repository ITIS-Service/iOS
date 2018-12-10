//
//  TextFieldTableViewCell.swift
//  ITISService
//
//  Created by Timur Shafigullin on 10/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, Configurable {
    
    typealias T = AccountSettings.TableView.TextFieldModel
    
    // MARK: - Instance Properties

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    
    // MARK: -
    
    fileprivate let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.placeholder,
        .font: Fonts.light(ofSize: 17)
    ]
    
    // MARK: -
    
    var model: AccountSettings.TableView.TextFieldModel?
    
    // MARK: - Instance Methods
    
    func configure(with model: AccountSettings.TableView.TextFieldModel) {
        self.model = model
        self.titleLabel.text = model.title
        
        if let placeholder = model.placeholder {
            self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.placeholderAttributes)
        }
    }
}

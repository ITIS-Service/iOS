//
//  UIAlertController + Extension.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 06/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func errorAlert(with message: String) -> UIAlertController {
        let controller = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return controller
    }
    
}

//
//  UIView + Extension.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

extension UIView {
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
    static func nib()-> UINib {
        return UINib(nibName: self.identifier(), bundle: Bundle.main)
    }
    
}

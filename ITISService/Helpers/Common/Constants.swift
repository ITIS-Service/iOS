//
//  Constants.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 22/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

public enum Common {
    
    struct Autorization {
        static let placeholderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1)
        static let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont(name: "HelveticaNeue-Light", size: 14)!
        ]
        static let errorColor = UIColor(red: 192 / 255.0, green: 55 / 255.0, blue: 46 / 255.0, alpha: 1)
    }
    
    struct Messages {
        static let invalidEmail = "Неверный формат e-mail адреса. Используйте почту от КФУ с доменом @stud.kpfu.ru"
    }
    
    struct Scene {
        static let navTitleColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 149 / 255.0, alpha: 1)
    }
    
}

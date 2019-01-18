//
//  UIScreen + Extension.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 06/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

public extension UIScreen {
    
    public static func isIphone5Screen() -> Bool {
        return UIScreen.main.nativeBounds.height == 1136
    }
    
}


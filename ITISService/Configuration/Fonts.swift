//
//  Fonts.swift
//  ITISService
//
//  Created by Timur Shafigullin on 27/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

enum Fonts {
    
    // MARK: - Type properties
    
    static func light(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    static func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
}

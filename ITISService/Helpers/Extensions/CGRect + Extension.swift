//
//  CGRectExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGRect {
    
    // MARK: - Instance Properties
    
    public var top: CGFloat {
        return self.origin.y
    }
    
    public var bottom: CGFloat {
        return self.origin.y + self.size.height
    }
    
    public var left: CGFloat {
        return self.origin.x
    }
    
    public var right: CGFloat {
        return self.origin.x + self.size.width
    }
    
    // MARK: -
    
    public var adjusted: CGRect {
        return CGRect(x: Int(floor(self.origin.x)),
                      y: Int(floor(self.origin.y)),
                      width: Int(ceil(self.size.width)),
                      height: Int(ceil(self.size.height)))
    }
    
    // MARK: - Initializers
    
    public init(x: CGFloat, y: CGFloat, size: CGSize) {
        self.init(x: x, y: y, width: size.width, height: size.height)
    }
    
    public init(x: Double, y: Double, size: CGSize) {
        self.init(x: x, y: y, width: Double(size.width), height: Double(size.height))
    }
    
    public init(x: Int, y: Int, size: CGSize) {
        self.init(x: CGFloat(x), y: CGFloat(y), width: size.width, height: size.height)
    }
}

//
//  PointsFooterView.swift
//  ITISService
//
//  Created by Timur Shafigullin on 02/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

@IBDesignable
class PointsFooterView: UIView {
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var pointsCountLabel: UILabel!
    
    // MARK: -
    
    @IBInspectable var pointsCount: String? {
        get {
            return self.pointsCountLabel.text
        }
        
        set {
            self.pointsCountLabel.text = pointsCount
        }
    }
    
    // MARK: - Instance Methods
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed("PointsFooterView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

}

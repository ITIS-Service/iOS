//
//  EmptyState.swift
//  ITISService
//
//  Created by Timur Shafigullin on 29/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

struct EmptyState {
    
    let title: String
    let buttonTitle: String?
    let subtitle: String?
    let image: UIImage?
    
    init(title: String, buttonTitle: String? = nil, subtitle: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.subtitle = subtitle
        self.image = image
    }
    
}

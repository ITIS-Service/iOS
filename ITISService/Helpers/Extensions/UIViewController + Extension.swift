//
//  UIViewController + Extension.swift
//  ITISService
//
//  Created by Timur Shafigullin on 29/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Instance Methods
    
    func present(alertController: UIAlertController, animated: Bool, completion: (() -> Void)? = nil) {
        let backgroundView = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        
        backgroundView.backgroundColor = Colors.barBackground
        backgroundView.layer.cornerRadius = 10
        
        if let title = alertController.title {
            let titleMutableString = NSMutableAttributedString(string: title,
                                                               attributes: [NSAttributedString.Key.font: Fonts.medium(ofSize: 17),
                                                                            NSAttributedString.Key.foregroundColor: Colors.white])
            
            alertController.setValue(titleMutableString, forKey: "attributedTitle")
        }
        
        if let message = alertController.message {
            let messageMutableString = NSMutableAttributedString(string: message,
                                                                 attributes: [NSAttributedString.Key.font: Fonts.regular(ofSize: 13),
                                                                              NSAttributedString.Key.foregroundColor: Colors.white])
            
            alertController.setValue(messageMutableString, forKey: "attributedMessage")
        }
        
        alertController.view.tintColor = Colors.orange
        
        self.present(alertController, animated: animated, completion: completion)
    }
}


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

    func showActivityIndicator() {
        let container = UIView()
        container.frame = self.frame
        container.center = self.center
        container.backgroundColor = UIColor(rgb: 0xffffff).withAlphaComponent(0.3)
        container.tag = activityTag()
        
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor(rgb: 0x444444).withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        let activityContainer = self.viewWithTag(activityTag())
        activityContainer?.removeFromSuperview()
    }
    
    private func activityTag() -> Int {
        let activityIndicatorTag = 56
        return activityIndicatorTag
    }
    
    
}

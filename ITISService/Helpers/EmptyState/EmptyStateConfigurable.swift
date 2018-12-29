//
//  EmptyStateConfigurable.swift
//  ITISService
//
//  Created by Timur Shafigullin on 28/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit
import UIEmptyState

protocol EmptyStateConfigurable: UIEmptyStateDataSource, UIEmptyStateDelegate {
    
    // MARK: - Instance Properties
    
    var emptyState: EmptyState! { get }
    
    // MARK: - Instance Methods
    
    func didEmptyStateButtonClicked()
}

extension EmptyStateConfigurable where Self: UIViewController {
    
    // MARK - UIEmptyStateDataSource
    
    var emptyStateImage: UIImage? {
        return self.emptyState.image
    }
    
    var emptyStateTitle: NSAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.emptyStateTitle,
            .font: Fonts.regular(ofSize: 22)
        ]
        
        return NSAttributedString(string: self.emptyState.title, attributes: attrs)
    }
    
    var emptyStateDetailMessage: NSAttributedString? {
        guard let subtitle = self.emptyState.subtitle else {
            return nil
        }
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.white,
            .font: Fonts.regular(ofSize: 16)
        ]
        
        return NSAttributedString(string: subtitle, attributes: attrs)
    }
    
    var emptyStateButtonTitle: NSAttributedString? {
        guard let buttonTitle = self.emptyState.buttonTitle else {
            return nil
        }
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.white,
            .font: Fonts.regular(ofSize: 16)
        ]
        
        return NSAttributedString(string: buttonTitle, attributes: attrs)
    }
    
    var emptyStateButtonSize: CGSize? {
        guard self.emptyState.buttonTitle != nil else {
            return nil
        }
        
        return CGSize(width: 100, height: 40)
    }
    
    // MARK - UIEmptyStateDelegate
    
    func emptyStateViewWillShow(view: UIView) {
        guard let emptyView = view as? UIEmptyStateView else { return }
        emptyView.button.layer.cornerRadius = 5
        emptyView.button.layer.borderWidth = 1
        emptyView.button.layer.borderColor = Colors.red.cgColor
        emptyView.button.layer.backgroundColor = Colors.red.cgColor
    }
    
    func emptyStatebuttonWasTapped(button: UIButton) {
        self.didEmptyStateButtonClicked()
    }
    
}

//
//  ErrorPresenter.swift
//  ITISService
//
//  Created by Timur Shafigullin on 10/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

protocol ErrorMessagePresenter: class {
    
    // MARK: - Instance Properties
    
    var presenterController: UIViewController { get }
    
    // MARK: - Instance Methods
    
    func showMesssage(with error: ExceptionResponse, okHandler: (() -> Void)?)
    func showMesssage(with error: ExceptionResponse)
}

// MARK: -

extension ErrorMessagePresenter where Self: UIViewController {
    
    // MARK: - Instance Properties
    
    var presenterController: UIViewController {
        return self
    }
    
    // MARK: - Instance Methods
    
    func showMesssage(with error: ExceptionResponse, okHandler: (() -> Void)?) {
        let alert = UIAlertController(title: "Ошибка", message: error.message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            okHandler?()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func showMesssage(with error: ExceptionResponse) {
        self.showMesssage(with: error, okHandler: nil)
    }
}

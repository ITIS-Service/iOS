//
//  ErrorMessagePresentationLogic.swift
//  ITISService
//
//  Created by Timur Shafigullin on 24/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

protocol ErrorMessagePrentationLogic {
    
    // MARK: - Instance Properties
    
    var errorMessagePresenter: ErrorMessagePresenter! { get }
    
    // MARK: - Instance Methods
    
    func showAlert(with error: ExceptionResponse)
}

// MARK: -

extension ErrorMessagePrentationLogic {
    
    // MARK: - Instance Methods
    
    func showAlert(with error: ExceptionResponse) {
        self.errorMessagePresenter.showMesssage(with: error)
    }
}

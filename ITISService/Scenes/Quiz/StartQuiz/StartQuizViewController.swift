//
//  StartQuizViewController.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class StartQuizViewController: UIViewController, ErrorMessagePresenter {
    
    // MARK: - Nested Types
    
    fileprivate enum Segues {
        
        // MARK: - Type Properties
        
        static let showQuestions = "questionViewController"
    }

    // MARK: - Instance Methods
    
    @IBAction fileprivate func onStartQuizButtonClick(_ sender: UIButton) {
        self.view.showActivityIndicator()
        
        NetworkManagers.userNetworkManager.fetchQuestions(success: { [weak self] (questions) in
            guard let strongSelf = self else { return }
            QuizManager.shared.questions = questions
            strongSelf.view.hideActivityIndicator()
            strongSelf.performSegue(withIdentifier: Segues.showQuestions, sender: nil)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.view.hideActivityIndicator()
            strongSelf.showMesssage(with: error)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

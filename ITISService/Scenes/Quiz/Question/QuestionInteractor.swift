//
//  QuestionInteractor.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright (c) 2018 Timur Shafigullin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol QuestionBusinessLogic {
    func getNextQuestion()
    func writeAnswer(with request: Question.Answer.Request)
    func unselectOtherButtons(with request: Question.Buttons.Request)
    func previousQuestion()
}

protocol QuestionDataStore {
    //var name: String { get set }
}

class QuestionInteractor: QuestionBusinessLogic, QuestionDataStore {
    
    var presenter: QuestionPresentationLogic!
    var worker: QuestionWorker!
    var userNetworkManager: UserNetworkManager!
    
    func getNextQuestion() {
        if let question = QuizManager.shared.nextQuestion() {
            self.presenter.showQuestion(with: Question.Show.Response(question: question, questionNumber: QuizManager.shared.currentNumber, questionNumbers: QuizManager.shared.questions.count))
        }
    }
    
    func previousQuestion() {
        QuizManager.shared.currentNumber -= 1;
    }

    func writeAnswer(with request: Question.Answer.Request) {
        QuizManager.shared.writeAnswer(at: request.answerIndex)
        if QuizManager.shared.hasNextQuestion() {
            self.presenter.showNextQuestionScreen()
        } else {
            self.presenter.showActivityIndicator(true)
            
            var preparedAnswers = [String: Int]()
            QuizManager.shared.buffer.forEach { key, value in
                preparedAnswers[String(key)] = value
            }
            
            self.userNetworkManager.sendAnswers(with: preparedAnswers, success: { [weak self] (response) in
                self?.presenter.showActivityIndicator(false)
                self?.presenter.showCoursesScreen()
                
                NotificationCenter.default.post(name: .userDidFinishQuiz, object: self)
            }) { [weak self] (error) in
                self?.presenter.showActivityIndicator(false)
                self?.presenter.showError(error)
            }
        }
    }
    
    func unselectOtherButtons(with request: Question.Buttons.Request) {
        self.presenter.unselectOtherButton(with: Question.Buttons.Response(selectedButtonIndex: request.selectedButtonIndex, buttonsCount: request.buttonsCount))
    }
    
}

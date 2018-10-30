//
//  QuizManager.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class QuizManager {
    
    static let shared = QuizManager()
    var buffer = [Int: Int]()
    var currentNumber = 0
    var questions = [QuizQuestion]()
    
    func writeAnswer(at index: Int) {
        let currentQuestion = self.questions[currentNumber - 1]
        buffer[currentQuestion.id] = currentQuestion.answers[index].id
    }
    
    func nextQuestion() -> QuizQuestion? {
        defer { currentNumber += 1 }
        if questions.count - 1 >= currentNumber {
            return self.questions[currentNumber]
        }
        return nil
    }
    
    func hasNextQuestion() -> Bool {
        return questions.count - 1 >= currentNumber
    }
    
}

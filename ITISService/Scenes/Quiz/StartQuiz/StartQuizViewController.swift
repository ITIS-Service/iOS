//
//  StartQuizViewController.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 27/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class StartQuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateData()
    }
    
    @IBAction func onStartQuizButtonClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "questionViewController", sender: nil)
    }
    
    func generateData() {
        let answer1 = Answer(id: 1, title: "Java")
        let answer2 = Answer(id: 2, title: "Python")
        let answer3 = Answer(id: 3, title: "Ruby")
        let answer4 = Answer(id: 4, title: "PHP")
        
        let answer5 = Answer(id: 5, title: "Математический анализ")
        let answer6 = Answer(id: 6, title: "Алгоритмы и структуры данных")
        let answer7 = Answer(id: 7, title: "БЖД")
        
        let question1 = QuizQuestion(id: 1, title: "Какой язык программирования вы предпочитаете или хотели бы изучить?", answers: [answer1, answer2, answer3, answer4])
        let question2 = QuizQuestion(id: 2, title: "Какой из предметов вам легче дается или нравится больше?", answers: [answer5, answer6, answer7])
        
        QuizManager.shared.questions = [question1, question2]
    }
    
    
}

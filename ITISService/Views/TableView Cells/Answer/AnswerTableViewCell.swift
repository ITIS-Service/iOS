//
//  AnswerTableViewCell.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 28/10/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

protocol AnswerTableViewCellDelegate: class {
    func didAnswerButtonClicked(_ button: UIButton, at index: Int)
}

class AnswerTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var answerButton: UIButton!
    
    typealias T = Question.AnswersTableView.Model
    var model: Question.AnswersTableView.Model?
    weak var delegate: AnswerTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.answerButton.layer.borderColor = UIColor.white.cgColor
        self.answerButton.layer.borderWidth = 1
        self.answerButton.layer.cornerRadius = 6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.answerButton.backgroundColor = .clear
        self.answerButton.setTitleColor(.white, for: .normal)
    }
    
    func configure(with model: Question.AnswersTableView.Model) {
        self.model = model
        self.answerButton.setTitle(model.answerTitle, for: .normal)
    }
    
    @IBAction func onAnswerButtonClick(_ sender: UIButton) {
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
        self.delegate?.didAnswerButtonClicked(sender, at: self.model!.index)
    }
    
}

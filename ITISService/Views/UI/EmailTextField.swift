//
//  EmailTextField.swift
//  ITISService
//
//  Created by Timur Shafigullin on 08/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import UIKit

class EmailTextField: UITextField {
    
    fileprivate struct Constants {
        static let studDomen = "@stud.kpfu.ru"
    }
    
    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate

extension EmailTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            var updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if (!updatedText.contains(Constants.studDomen)) {
                updatedText += Constants.studDomen
                textField.text = updatedText
                
                if let newCursorPosition = textField.position(from: textField.beginningOfDocument, offset: updatedText.count - Constants.studDomen.count) {
                    textField.selectedTextRange = textField.textRange(from: newCursorPosition, to: newCursorPosition)
                }
                return false
            }
        }
        return true
    }
    
}

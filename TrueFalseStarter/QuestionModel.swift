//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Softpak Financial Systems on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    
    let question: String
    let options: [String]
    let answerKey: Int

    
    init(question: String, options: [String], answerKey: Int){
        self.question = question
        self.options = options
        self.answerKey = answerKey - 1  // this is because the options are in order format 1-4, and we need to convert this so it it matches an array format 0-3, so an answerKey of "2" will be "1" when we're referring to it in array
    }
    
    func isCorrect(answer: String) -> Bool {
        return answer == self.options[answerKey]
    }
    
    
}

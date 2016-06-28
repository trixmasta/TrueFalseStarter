//
//  TriviaModel.swift
//  TrueFalseStarter
//
//  Created by Softpak Financial Systems on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct Trivia {
    
    
    let question1 = Question(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington","Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"], answerKey: 2)
    
    let question2 = Question(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answerKey: 1)
    
    let question3 = Question(question: "In what year was the United Nations founded?", options: ["1918","1919","1945","1954"], answerKey: 3)
    
    let question4 = Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris","Washington D.C.","New York City","Boston"], answerKey: 3)
    
    let question5 = Question(question: "Which nation produces the most oil?", options: ["Iran","Iraq","Brazil","Canada"], answerKey: 4)
    
    let question6 = Question(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy","Brazil","Argentina","Spain"], answerKey: 2)
    
    let question7 = Question(question: "Which of the following rivers is longest?", options: ["Yangtze","Mississippi","Congo","Mekong"], answerKey: 2)
    
    let question8 = Question(question: "Which city is the oldest?", options: ["Mexico City","Cape Town","San Juan","Sydney"], answerKey: 1)
    
    let question9 = Question(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland","United States","Sweden","Senegal"], answerKey: 1)
    
     let question10 = Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France","Germany","Japan","Great Britian"], answerKey: 4)
    
    
    let list: [Question]
    
    var questionsPerRound: Int
    
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0

    
    init() {
        
        self.list = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]
        
        self.questionsPerRound = list.count
        
    }
    
    mutating func reset(){
        self.questionsAsked = 0
        self.correctQuestions = 0
    }
    
    
}
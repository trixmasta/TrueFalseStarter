//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    var gameSound: SystemSoundID = 0
    
    var trivia = Trivia(lightningMode: true)
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    @IBOutlet weak var lightningModeTimer: UILabel!
    
    var options: [UIButton] = []
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        options = [option1, option2, option3, option4]
        
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        trivia.indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.questions.count)
        
        print("index \(trivia.indexOfSelectedQuestion)")
        
        let questionDictionary = trivia.questions[trivia.indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        playAgainButton.hidden = true
        
        var optionIndex = 0
        for option in options {
            let optionString = questionDictionary.options[optionIndex]
            option.setTitle(optionString, forState: UIControlState.Normal)
            optionIndex += 1
        }
        
        if trivia.lightningMode {
            startTimer()
            
        }
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        for option in options {
            option.hidden = true
        }
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(trivia.correctQuestions) out of \(trivia.questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // call function that tells Trivia to increment number of questions asked and remove the asked question for future questions
        
        let selectedQuestionDict = trivia.questions[trivia.indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.isCorrect(sender.titleLabel!.text!)
        
        if  correctAnswer {
            trivia.correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        displayCorrectAnswer()
        
        trivia.questionFinished()  // must make sure this is placed properly, because this will remove item from array which can then potentially cause an indexOutOfBounds error
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        
        resetOptionsWithNewQuestion()
        
        if trivia.questionsAsked == trivia.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        for option in options {
            option.hidden = false
        }
        
        // reset the trivia game
        
        trivia = Trivia(lightningMode: true)
        
        nextRound()
    }
    
    func displayCorrectAnswer(){
        
        let indexOfCorrectAnswer = trivia.questions[trivia.indexOfSelectedQuestion].answerKey
        
        var i = 0
        
        for _ in options {
            
            switch i {
                
            case indexOfCorrectAnswer:
                options[i].alpha = 1.0
            default:
                options[i].alpha = 0.2
            }
            
            i += 1
        }
        
        
    }
    
    func skipQuestion(){
        // this is called when timer is up for question during lightning mode
        displayCorrectAnswer()
        
        trivia.questionFinished()

        loadNextRoundWithDelay(seconds: 2)
    }
    
    func startTimer(){
       
       trivia.time = NSTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.runTimer), userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(trivia.time, forMode: NSRunLoopCommonModes)
        
    }
    
    func displayTimerText(){
        let remainingSeconds = Int(trivia.lightningModeTimePerRound - trivia.timeElapsed)
        self.lightningModeTimer.text = "Time Left: \(remainingSeconds)"
    }
    
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    
    }
    
    func resetOptionsWithNewQuestion(){
        // change settings when new question is displayed
        
        // reset the display of options
        for option in options {
            option.alpha = 1.0
        }
        
        // reset the timer counter for this new question (if lightning mode is enabled)
        if trivia.lightningMode {
           
            trivia.timeElapsed = 0
        }
    }
    
    func runTimer(){
        
        if trivia.timeElapsed > trivia.lightningModeTimePerRound {
          
            skipQuestion()
            
        }else{
            
            displayTimerText()
            trivia.timeElapsed += 1
            
        }
        
    }

}


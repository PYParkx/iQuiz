//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 3/1/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var correctText: UILabel!
    @IBOutlet weak var indicator: UILabel!
    @IBOutlet weak var question: UILabel!
    var correctAnswer : Int? // Correct answer
    var answer : Int?  // User selected
    var questions : [Questions]? // array of questions
    var currentQuestionNum : Int? // current question
    var correct : Bool?
    var correctAnswerString : String?
    var correctTotal : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        if (correct == true) {
            self.indicator.text = "You got it Right!"
        } else {
            self.indicator.text = "You got it Wrong!"
        }
        self.question.text = self.questions![currentQuestionNum! - 1].text
        self.correctText.text = self.correctAnswerString
        self.correctText.sizeToFit()
        self.correctText.adjustsFontSizeToFitWidth = true
        self.question.sizeToFit()
        self.question.adjustsFontSizeToFitWidth = true
        self.indicator.sizeToFit()
        self.indicator.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func `continue`(_ sender: Any) {
        if ((currentQuestionNum!) == questions!.count) {
            performSegue(withIdentifier: "results", sender: self)
        } else {
            performSegue(withIdentifier: "question", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "question" {
            let questionViewController = segue.destination as! QuestionsViewController
            questionViewController.currentQuestionNum = self.currentQuestionNum!
            questionViewController.questions = self.questions
            questionViewController.correctTotal = self.correctTotal
        } else if segue.identifier == "results" {
            let finishedViewController = segue.destination as! FinishedViewController
            finishedViewController.correctTotal = self.correctTotal
            finishedViewController.questions = self.questions
        }
    }
    
}

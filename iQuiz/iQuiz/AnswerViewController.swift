//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 2/26/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var correctAnswer : Int? // Correct answer
    var answer : Int?  // User selected
    var questions : [Questions]? // array of questions
    var currentQuestionNum : Int? // current question
    var correct : Bool?
    var correctAnswerString : String?
    var correctTotal : Int!

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var correctText: UILabel!
    @IBOutlet weak var indicator: UILabel!
    
    
    @IBAction func `continue`(_ sender: UIButton) {
        if ((currentQuestionNum!) == questions!.count) {
            performSegue(withIdentifier: "results", sender: self)
        } else {
            performSegue(withIdentifier: "question", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (correct == true) {
            self.indicator.text = "You got it Right!"
        } else {
            self.indicator.text = "You got it Wrong!"
        }
        self.question.text = self.questions![currentQuestionNum! - 1].text
        self.correctText.text = self.correctAnswerString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "question" {
            let questionViewController = segue.destination as! QuestionViewController
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

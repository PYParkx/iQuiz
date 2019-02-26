//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 2/25/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    var correctAnswer : Int? 
    var answer : Int = -1; 
    var questions : [Questions]?
    var currentQuestionNum : Int = 0
    var correct : Bool?
    var correctAnswerString : String?
    var correctTotal : Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.question.text = questions![currentQuestionNum].text
        let answers : [String] = questions![currentQuestionNum].answers
        self.correctAnswer = Int(questions![currentQuestionNum].answer)
        self.correctAnswerString = answers[correctAnswer! - 1]
  
        
        var buttons : [UIButton] = [choice1, choice2, choice3, choice4]
        
        for index in 0...(buttons.count - 1) {
            buttons[index].setTitle(answers[index], for: .normal)
        }
    }
    
    @IBAction func choice1Selected(_ sender: UIButton) {
        answer = 1;
        sender.backgroundColor = UIColor.green
        choice2.backgroundColor = UIColor.white
        choice3.backgroundColor = UIColor.white
        choice4.backgroundColor = UIColor.white
    }
    
    @IBAction func choice2Selected(_ sender: UIButton) {
        answer = 2;
        sender.backgroundColor = UIColor.green
        choice1.backgroundColor = UIColor.white
        choice3.backgroundColor = UIColor.white
        choice4.backgroundColor = UIColor.white

    }
    
    @IBAction func choice3Selected(_ sender: UIButton) {
        answer = 3;
        sender.backgroundColor = UIColor.green
        choice2.backgroundColor = UIColor.white
        choice1.backgroundColor = UIColor.white
        choice4.backgroundColor = UIColor.white

    }
    
    @IBAction func choice4Selected(_ sender: UIButton) {
        answer = 4;
        sender.backgroundColor = UIColor.green
        choice2.backgroundColor = UIColor.white
        choice3.backgroundColor = UIColor.white
        choice1.backgroundColor = UIColor.white

    }
    
    @IBAction func submit(_ sender: Any) {
        if answer == -1 {
            let alert = UIAlertController(title: "Wait!", message: "Please Select an Answer or Press Back to go home.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "answers", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "answers" {
            let answerViewController = segue.destination as! AnswerViewController
            self.currentQuestionNum += 1
            answerViewController.correctAnswer = self.correctAnswer
            answerViewController.correctAnswerString = self.correctAnswerString
            answerViewController.correct = (self.answer == self.correctAnswer)
            answerViewController.currentQuestionNum = self.currentQuestionNum
            answerViewController.questions = self.questions
            if (self.answer == self.correctAnswer!) {
                self.correctTotal += 1
            }
            answerViewController.correctTotal = self.correctTotal
        }
    }
}

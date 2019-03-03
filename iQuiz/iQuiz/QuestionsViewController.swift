//
//  QuestionsViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 3/1/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    var correctAnswer : Int?
    var answer : Int = -1;
    var questions : [Questions]?
    var currentQuestionNum : Int = 0
    var correct : Bool?
    var correctAnswerString : String?
    var correctTotal : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionTitle.text = questions![currentQuestionNum].text
        let answers : [String] = questions![currentQuestionNum].answers
        self.correctAnswer = Int(questions![currentQuestionNum].answer)
        self.correctAnswerString = answers[correctAnswer! - 1]
        
        
        var buttons : [UIButton] = [option1, option2, option3, option4]
        
        for index in 0...(buttons.count - 1) {
            buttons[index].setTitle(answers[index], for: .normal)
        }
        self.questionTitle.sizeToFit()
        self.questionTitle.adjustsFontSizeToFitWidth = true
        self.questionTitle.font = questionTitle.font.withSize(22)
        
        self.option1.titleLabel?.sizeToFit()
        self.option1.titleLabel?.adjustsFontSizeToFitWidth = true;
        self.option1.titleLabel?.font = self.option1.titleLabel?.font.withSize(20)
        
        self.option2.titleLabel?.sizeToFit()
        self.option2.titleLabel?.adjustsFontSizeToFitWidth = true
         self.option2.titleLabel?.font = self.option2.titleLabel?.font.withSize(20)
        
        self.option3.titleLabel?.sizeToFit()
        self.option3.titleLabel?.adjustsFontSizeToFitWidth = true;
         self.option3.titleLabel?.font = self.option3.titleLabel?.font.withSize(20)
        
        self.option4.titleLabel?.sizeToFit()
        self.option4.titleLabel?.adjustsFontSizeToFitWidth = true;
         self.option4.titleLabel?.font = self.option1.titleLabel?.font.withSize(20)


        

    }
    
    @IBAction func choice1Selected(_ sender: UIButton) {
        self.answer = 1;
        sender.backgroundColor = UIColor.green
        option2.backgroundColor = UIColor.white
        option3.backgroundColor = UIColor.white
        option4.backgroundColor = UIColor.white
    }
    
    @IBAction func choice2Selected(_ sender: UIButton) {
        self.answer = 2;
        sender.backgroundColor = UIColor.green
        option1.backgroundColor = UIColor.white
        option3.backgroundColor = UIColor.white
        option4.backgroundColor = UIColor.white
    }
    @IBAction func choice3Selected(_ sender: UIButton) {
        self.answer = 3;
        sender.backgroundColor = UIColor.green
        option2.backgroundColor = UIColor.white
        option1.backgroundColor = UIColor.white
        option4.backgroundColor = UIColor.white
        
    }
    
    @IBAction func choice4Selected(_ sender: UIButton) {
        self.answer = 4;
        sender.backgroundColor = UIColor.green
        option2.backgroundColor = UIColor.white
        option3.backgroundColor = UIColor.white
        option1.backgroundColor = UIColor.white
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
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "master", sender: self)
        
    }
    @IBAction func submit(_ sender: Any) {
        if self.answer != -1 {
            performSegue(withIdentifier: "answers", sender: self)
        } else {
            print("yeet")
        }
    }
}

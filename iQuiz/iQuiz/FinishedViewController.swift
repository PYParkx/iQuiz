//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 2/26/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var questions : [Questions]?
    var correctTotal : Int!
    @IBOutlet weak var performance: UILabel!
    @IBOutlet weak var score: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.score.text = "You got \(correctTotal!) out of \(questions!.count)"
        if (correctTotal == questions!.count) {
            self.performance.text = "Perfect Score!"
        } else if (correctTotal! < questions!.count) {
            self.performance.text = "Almost Perfect!"
        }
    }

}

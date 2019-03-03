//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 3/1/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var questions : [Questions]?
    var correctTotal : Int!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var performance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.score.text = "You got \(correctTotal!) out of \(questions!.count)"
        if (correctTotal == questions!.count) {
            self.performance.text = "Perfect Score!"
        } else if (correctTotal! < questions!.count) {
            self.performance.text = "Almost Perfect!"
        }
        self.performance.sizeToFit()
        self.performance.adjustsFontSizeToFitWidth = true
        self.score.sizeToFit()
        self.score.adjustsFontSizeToFitWidth = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

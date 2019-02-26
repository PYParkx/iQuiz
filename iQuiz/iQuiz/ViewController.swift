//
//  ViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 2/21/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    
    var quizList : [String] = ["Mathematics", "Marvel Super Heros", "Science"]
    var desList : [String] = ["Math sucks", "Iron", "Yeet"]
//    var imaage = ["math.jpg", "superhero.jpg", "science.jpg"]
    var images = ["math.jpg", "superhero.jpg", "science.jpg"]
    


    
    @IBAction func setting(_ sender: Any) {
        print("I was pressed")
        let alert = UIAlertController(title: "Setting", message: "Swag!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? QuizTableViewCell else {
            return UITableViewCell()
        }

        let text = quizList[indexPath.row]
        let des = desList[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])


        cell.title.text = text
        cell.descr.text = des
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        tableView.delegate = self
        tableView.dataSource = self
    }


}


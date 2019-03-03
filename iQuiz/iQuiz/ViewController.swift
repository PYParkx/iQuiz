//
//  ViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 3/1/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit
import SystemConfiguration

struct Questions : Codable {
    var text : String
    var answers : [String]
    var answer : String
}

struct Quiz : Codable {
    var title : String
    var desc : String
    var questions: [Questions]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var images = ["math.jpg", "superhero.jpg", "science.jpg"]
    var quizzes : [Quiz] = []
    var urlJson: String =  UserDefaults.standard.string(forKey: "url") ?? "http://tednewardsandbox.site44.com/questions.json"
    var defaults = UserDefaults.standard

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? QuizTableViewCell else {
            return UITableViewCell()
        }
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.title?.text = quizzes[indexPath.row].title
        cell.desc?.text = quizzes[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((defaults.object(forKey: "url")) != nil){
            self.urlJson = defaults.object(forKey: "url") as! String
        }
        getJson(self.urlJson)
        tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(Reachability.isConnectedToNetwork()){
            getJson(self.urlJson)
        }else{
            if(defaults.string(forKey: "url") == nil){
                let alert = UIAlertController(title: "Warning!", message: "Please connect to the internet!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.alertNoConnection()
                getJson(urlJson)
                }
            }
        
            
            
    }
    
    
    func alertNoConnection() {
        let alert = UIAlertController(title: "Warning", message: "No internet connection therfore using local data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertDownLoadFailed() {
        let alert = UIAlertController(title: "Warning", message: "Download Failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func setting(_ sender: Any) {
        let alertController = UIAlertController(title: "Setting", message:
            "Enter url to use", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {textField in
            textField.placeholder = "Enter URL Here!"
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "Check Now", style: .default,handler: {(_) in
            let input = (alertController.textFields![0] as UITextField).text!
            if let url = URL(string: input), UIApplication.shared.canOpenURL(url) {
                self.getJson(input)
            } else {
                self.alertDownLoadFailed()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getJson(_ urlString: String) {
        guard let url : URL = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                let model = try JSONDecoder().decode([Quiz].self, from:
                    dataResponse)
                DispatchQueue.main.async {
                    self.quizzes = model
                    self.defaults.set(urlString, forKey: "url")
                    self.tableView.reloadData()
                    
                }
            }  catch let parsingError {
                print("Error parsing", parsingError)
            }
        }
        task.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let row = indexPath[1]
            let questionViewController = segue.destination as! QuestionsViewController
            questionViewController.questions = self.quizzes[row].questions

        }
    }
}


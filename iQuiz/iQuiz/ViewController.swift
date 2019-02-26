//
//  ViewController.swift
//  iQuiz
//
//  Created by Phillip Park on 2/21/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {
    @IBOutlet weak var tableView: UITableView!
    
    var images = ["math.jpg", "superhero.jpg", "science.jpg"]
    var quizzes : [Quiz] = []
    var urlJson: String = "https://tednewardsandbox.site44.com/questions.json"
    let itemName = "myJSONFromWeb"
    let defaults = UserDefaults.standard
    var settingInput: UITextField = UITextField()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() {
            getJson(urlJson)
        } else {
            alertNoConnection()
            let fileUrl = defaults.url(forKey: "pathForJSON")
            do {
                let jsonData2 = try Data(contentsOf: fileUrl!, options: [])
                let myJson = try JSONSerialization.jsonObject(with: jsonData2, options: .mutableContainers)
                let model = try JSONDecoder().decode([Quiz].self, from:
                    jsonData2) //Decode JSON Response Data
                //...do thing with you JSON file
                //           DispatchQueue.main.async {
                self.quizzes = model
                self.tableView?.reloadData()
            } catch {
                print(error)
            }
        }
    }

    func getJson(_ urlget: String) {
        guard let url : URL = URL(string: urlget) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                //here dataResponse received from a network request
                let model = try JSONDecoder().decode([Quiz].self, from:
                    dataResponse) //Decode JSON Response Data
                DispatchQueue.main.async {
                    self.quizzes = model
                    self.tableView?.reloadData()

                }
            } catch let parsingError {
                print("Error parsing", parsingError)
            }
        }
        task.resume()
    }
    
    func download(_ url: String) {
        let hostedJSONFile = url
        let jsonURL = URL(string: hostedJSONFile)
        let defaults = UserDefaults.standard
        let itemName = "myJSONFromWeb"
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = directory.appendingPathComponent(itemName)
            let jsonData = try Data(contentsOf: jsonURL!)
            try jsonData.write(to: fileURL, options: .atomic)
            //Save the location of your JSON file to UserDefaults
            defaults.set(fileURL, forKey: "pathForJSON")
            getJson(url)
        } catch {
            alertDownLoadFailed()
        }
    }

    
    @IBAction func setting(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter a URL to Use", preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            self.settingInput = textField
            self.settingInput.placeholder = "Enter URL Here!"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: {
            (act: UIAlertAction) in
            if (self.settingInput.text != nil) {
                self.download(self.settingInput.text!)
            }
        }
        ))

        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? QuizTableViewCell else {
            return UITableViewCell()
        }
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.title?.text = quizzes[indexPath.row].title
        cell.descr?.text = quizzes[indexPath.row].desc
        return cell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let row = indexPath[1]
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.questions = self.quizzes[row].questions
        }
    }

}


//
//  ViewController.swift
//  GuessTheflag
//
//  Created by Juan Ramírez Blancas on 14/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    private var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion(action: nil)
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "chart.bar"), target: self, action: #selector(showScore))
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
//            score -= 1
        }
        questionAsked += 1
        let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alertController, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        if questionAsked < 10 {
            countries.shuffle()
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            correctAnswer = Int.random(in: 0...2)
            title = "\(countries[correctAnswer].uppercased())"
        } else {
            
            let alertController = UIAlertController(title: "End of Game", message: "You got  \(score) / 10", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Play again", style: .default, handler: gameReset))
            present(alertController, animated: true)
        }
    }
    
    func gameReset(action: UIAlertAction! = nil) {
        questionAsked = 0
        score = 0
        askQuestion(action: nil)
    }
    
    @objc func restartGame() {
        let alertController = UIAlertController(title: "Restart game?", message: "You'll loose all your points", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: gameReset))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alertController, animated: true)
    }
    
    @objc func showScore() {
        let alertController = UIAlertController(title: "Score", message: "You got  \(score) / \(questionAsked)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }

}


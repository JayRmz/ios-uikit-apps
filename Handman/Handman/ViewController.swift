//
//  ViewController.swift
//  Handman
//
//  Created by Juan Ramírez Blancas on 25/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var AButton: UIButton!
    @IBOutlet var BButton: UIButton!
    @IBOutlet var cButton: UIButton!
    @IBOutlet var dButton: UIButton!
    @IBOutlet var eButton: UIButton!
    @IBOutlet var fButton: UIButton!
    @IBOutlet var gButton: UIButton!
    @IBOutlet var hButton: UIButton!
    @IBOutlet var jButton: UIButton!
    @IBOutlet var iButton: UIButton!
    @IBOutlet var kButton: UIButton!
    @IBOutlet var lButton: UIButton!
    @IBOutlet var mButton: UIButton!
    @IBOutlet var nButton: UIButton!
    @IBOutlet var pButton: UIButton!
    @IBOutlet var dashButton: UIButton!
    @IBOutlet var oButton: UIButton!
    @IBOutlet var qButton: UIButton!
    @IBOutlet var rButton: UIButton!
    @IBOutlet var sButton: UIButton!
    @IBOutlet var tButton: UIButton!
    @IBOutlet var uButton: UIButton!
    @IBOutlet var vButton: UIButton!
    @IBOutlet var wButton: UIButton!
    @IBOutlet var xButton: UIButton!
    @IBOutlet var yButton: UIButton!
    @IBOutlet var zButton: UIButton!
    @IBOutlet var atButton: UIButton!
    var errors = 0
    var clueString = ""
    var answerString = ""
    
    let letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","@","-"]
    var usedLetters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showClue))
        
        
        loadWord()
        
        scoreLabel.text = "Mistakes: \(errors)"
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        let checking = letters[sender.tag - 1]
       var missingLetters = false
        
        if usedLetters.contains(checking) {
            errors += 1
        } else {
            usedLetters.append(checking)
            if !answerString.contains(checking) {
                errors += 1
            } else {
                wordLabel.text! = ""
                
                for (index, letter) in answerString.enumerated() {
                    let strLetter = String(letter)

                    if usedLetters.contains(strLetter) {
                        wordLabel.text! += strLetter
                    } else {
                        wordLabel.text! += "?"
                        missingLetters = true
                    }
                    
            
                }
            }
            
        }
        
        if !missingLetters {
            showGameWon()
        }
        
        if errors >= 6 {
            showGameOver()
        }
        
       updateScore()
        DispatchQueue.main.async {
            sender.tintColor = UIColor(named: "TextSelected")
        }
        
    }
    
    func updateScore() {
        DispatchQueue.main.async {
            self.scoreLabel.text = "Mistakes: \(self.errors)"
        }
    }
    
    func showGameOver() {
        let ac = UIAlertController(title: "Game Over", message: "You have reached the max number of errors.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
        
        present(ac, animated: true)
    }
    
    func showGameWon() {
        let ac = UIAlertController(title: "You win!", message: "You just won the game!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: restartGame))
        
        present(ac, animated: true)
    }
    
   @objc func restartGame(action: UIAlertAction) {
        DispatchQueue.main.async {
            self.resetButtons()
            self.loadWord()
            self.updateScore()
        }
    }
    
    func resetButtons(){
        AButton.tintColor = UIColor(named: "Text")
        BButton.tintColor = UIColor(named: "Text")
        cButton.tintColor = UIColor(named: "Text")
        dButton.tintColor = UIColor(named: "Text")
        eButton.tintColor = UIColor(named: "Text")
        fButton.tintColor = UIColor(named: "Text")
        gButton.tintColor = UIColor(named: "Text")
        hButton.tintColor = UIColor(named: "Text")
        iButton.tintColor = UIColor(named: "Text")
        jButton.tintColor = UIColor(named: "Text")
        kButton.tintColor = UIColor(named: "Text")
        lButton.tintColor = UIColor(named: "Text")
        mButton.tintColor = UIColor(named: "Text")
        nButton.tintColor = UIColor(named: "Text")
        oButton.tintColor = UIColor(named: "Text")
        pButton.tintColor = UIColor(named: "Text")
        qButton.tintColor = UIColor(named: "Text")
        rButton.tintColor = UIColor(named: "Text")
        sButton.tintColor = UIColor(named: "Text")
        tButton.tintColor = UIColor(named: "Text")
        uButton.tintColor = UIColor(named: "Text")
        vButton.tintColor = UIColor(named: "Text")
        wButton.tintColor = UIColor(named: "Text")
        xButton.tintColor = UIColor(named: "Text")
        yButton.tintColor = UIColor(named: "Text")
        zButton.tintColor = UIColor(named: "Text")
        atButton.tintColor = UIColor(named: "Text")
        dashButton.tintColor = UIColor(named: "Text")
    }
    
    
    
    @objc func showClue() {
        let ac = UIAlertController(title: "Clue", message: clueString, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func loadWord() {
        
        answerString = ""
        clueString = ""
        usedLetters = []
        errors = 0
        
        if let levelFileURL = Bundle.main.url(forResource: "SwiftyHandman", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                let playingLine = lines[0]
                let parts = playingLine.components(separatedBy: ": ")
                answerString = parts[0].lowercased()
                clueString = parts[1]
                wordLabel.text = ""
                for letter in answerString {
                    if letter != " " {
                        wordLabel.text! += "?"
                    } else {
                        wordLabel.text! += " "
                        usedLetters.append(" ")
                    }
                }
            }
        }
    }


}


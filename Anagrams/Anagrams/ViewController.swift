//
//  ViewController.swift
//  Anagrams
//
//  Created by Juan Ramírez Blancas on 20/04/24.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords.append("silkworm")
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func restartGame() {
        startGame()
    }
    
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        var errorTitle: String = ""
        var errorMessage: String = ""
        var hasErrors = false
        
        guard let title = title?.lowercased() else { return }
        
        if isOriginalWord(word: lowerAnswer) {
            errorTitle = "Not the original!"
            errorMessage = "You just didn't really added \(title) as a word .-. do you?"
            hasErrors = true
        }
        
        if !isPossible(word: lowerAnswer) {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
            hasErrors = true
        }
        
        if !isNewWord(word: lowerAnswer) {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
            hasErrors = true
        }
        
        if !isReal(word: lowerAnswer) {
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
            hasErrors = true
        }
        
        if lowerAnswer.count < 3 {
            errorTitle = "Short word"
            errorMessage = "Words need to be at least 3 characters long"
            hasErrors = true
        }
        
        if hasErrors {
            showErrorAlert(errorTitle, errorMessage)
            return
        }
        
        usedWords.insert(lowerAnswer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func showErrorAlert(_ title: String, _ message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func isOriginalWord(word: String) -> Bool {
        guard var originalWord = title?.lowercased() else {return false}
        return word == originalWord
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isNewWord(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}


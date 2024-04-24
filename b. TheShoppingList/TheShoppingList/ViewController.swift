//
//  ViewController.swift
//  TheShoppingList
//
//  Created by Juan Ramírez Blancas on 21/04/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingListItems = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetList))
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingListItems[indexPath.row]
        return cell
    }
    
    @objc func resetList() {
        shoppingListItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Agregar", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Agregar", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        })
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        shoppingListItems.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}


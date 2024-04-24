//
//  ViewController.swift
//  ShareFlags
//
//  Created by Juan Ramírez Blancas on 15/03/24.
//

import UIKit

class ViewController: UITableViewController {
    
    private var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Share Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        pictures +=  ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Pictures count: \(pictures.count)")
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
        cell.textLabel?.text = "\(pictures[indexPath[1]].uppercased())"
        cell.imageView?.image = UIImage(named: pictures[indexPath[1]])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedFlag = self.pictures[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    
    
}


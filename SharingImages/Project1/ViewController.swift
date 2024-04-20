//
//  ViewController.swift
//  Project1
//
//  Created by Juan Ramírez Blancas on 02/03/24.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                print(item)
                pictures.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        pictures = pictures.sorted()
        
        cell.textLabel?.text = "Picture \( indexPath[1] + 1) of \(pictures.count)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedImage = pictures[indexPath.row]
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImage = self.selectedImage
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
   

}


//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Juan Ramírez Blancas on 22/04/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    var isFiltering = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                print("URL: \(url)")
                if let data = try? Data(contentsOf: url) {
                    print("Data: \(data)")
                    self.parse(json: data)
                    return
                }
                
                self.showError()
            }
        }
        
        
     
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfoAlert))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFilter))
        
    }
    
    
    @objc func showInfoAlert() {
        let ac = UIAlertController(title: "Credits", message: "Data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func searchFilter() {
        let ac = UIAlertController(title: "Filter By", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filter(answer)
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel){ [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filter("")
        })
        
        present(ac, animated: true)
    }
    
    func filter(_ filt: String) {
        let filterInput = filt.lowercased()
        
        isFiltering = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            if filterInput.isEmpty {
                self.isFiltering = false
                self.tableView.reloadData()
                return
            }
            
            
            for i in self.petitions {
                let petitionBody = i.body.lowercased()
                let petitionTitle = i.title.lowercased()
                
                if petitionBody.contains(filterInput) || petitionTitle.contains(filterInput) {
                    self.filteredPetitions.append(i)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
       
        print(filteredPetitions.count)
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredPetitions.count : petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = isFiltering ? filteredPetitions[indexPath.row] : petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


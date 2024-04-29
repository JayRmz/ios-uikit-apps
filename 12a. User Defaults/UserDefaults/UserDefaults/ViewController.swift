//
//  ViewController.swift
//  UserDefaults
//
//  Created by Juan Ramírez Blancas on 29/04/24.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Jay Ramirez", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        let ar = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()

        print("Array: \(ar)")
        
        let dic = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()

        print("Dict: \(dic)")
    }


}


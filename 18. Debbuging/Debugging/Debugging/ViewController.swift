//
//  ViewController.swift
//  Debugging
//
//  Created by Juan Ramírez Blancas on 07/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(1,2,3,4,5)
        
        //Separator
        print(1,2,3,4,5, separator: "-")
        
        //Terminator
        print("Some message", terminator: "")
        
        
        
        //Assertions
        assert(1 == 1, "Maths failure!")
//        assert(1 == 2, "Maths failure!") -> Error and app crashes
        
        
        //Breakpoints
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }


}


//
//  ViewController.swift
//  CareApp
//
//  Created by 髙津悠樹 on 2022/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messeageLabel: UILabel!
    
    
    
    let Messages = ["You are doing Great!", "Did you have any rest yet? If not, go get some!", "Get some hot drinks! You'll get less pain!"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messeageLabel.text = "You are doing Great!"
        // Do any additional setup after loading the view.
    }
    
    


}


//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 권대윤 on 2023/07/19.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var myButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainLabel.text = "안녕하세요"
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        mainLabel.text = "반갑습니다!"
        mainLabel.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        
    }
    
}



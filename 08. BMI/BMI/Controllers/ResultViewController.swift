//
//  ResultViewController.swift
//  BMI
//
//  Created by 권대윤 on 2023/07/27.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI() {
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.backgroundColor = .blue
        
        
        backButton.layer.cornerRadius = 5
        backButton.clipsToBounds = true
        backButton.setTitle("다시 계산하기", for: .normal)
        
        guard let resultValue = bmi?.value else {return}
        bmiNumberLabel.text = String(resultValue)
        
        adviceLabel.text = bmi?.advice
        
        bmiNumberLabel.backgroundColor = bmi?.matchColor
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}

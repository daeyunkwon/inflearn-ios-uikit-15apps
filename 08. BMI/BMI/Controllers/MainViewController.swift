//
//  ViewController.swift
//  BMI
//
//  Created by 권대윤 on 2023/07/27.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmiManager = BMICalculatorManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        
        calculateButton.layer.cornerRadius = 5
        calculateButton.clipsToBounds = true
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            return true
        } else {
            let alert = UIAlertController(title: "알림", message: "키와 몸무게를 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            guard let resultVC = segue.destination as? ResultViewController else {return}
            //BMI 결과값을 다음화면으로 전달하기
            resultVC.bmi = bmiManager.getBMIResult(height: heightTextField.text!, weight: weightTextField.text!)
        }
        //다음화면으로 가기전에 빈칸으로 지우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    
        
    
    

}


//MARK: - UITextFieldDelegate 메서드
extension MainViewController: UITextFieldDelegate {
    
    //숫자만 입력받기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        } else {
            return false
        }
    }
    
    //다음 텍스트필드로 이동시키기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        } else {
            return false
        }
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    
}

//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 권대윤 on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textField.delegate = self //대리자 -> 뷰 컨트롤러
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.systemGray6
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        textField.isSecureTextEntry = false
        textField.becomeFirstResponder()
        
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    //화면의 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

//MARK: 텍스트필드의 델리게이트 프로토콜 채택
extension ViewController: UITextFieldDelegate {
    
    //텍스트필드의 입력을 시작할 때 호출됨 (시작할지 말지의 여부 허락하는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 - 입력 시작 시 호출됨
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드에 입력을 시작했다")
    }
    
    //클리어 시도 시 호출됨 (클리어 동작 여부 허락하는 것)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    //텍스트필드 글자 내용이 한글자 한글자 입력되거나 지워질 때 호출됨 (입력 여부 허락하는 것)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //글자 수 제한
        let maxLength = 20
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

        return newString.length <= maxLength
    }
    
    //텍스트필드의 리턴키가 눌러지면 다음 동작을 허락할것인지 말것인지의 여부 허락하는 것
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        return false
    }
    
    //텍스트필드의 입력이 끝날때 호출 (끝날지 말지를 허락)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 - 텍스트필드의 입력이 끝났을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("입력끝")
    }
    
    
    
    
}


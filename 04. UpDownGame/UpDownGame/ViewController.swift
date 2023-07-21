//
//  ViewController.swift
//  UpDownGame
//
//  Created by 권대윤 on 2023/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    var comNumber: Int = Int.random(in: 1...10) //1~10 중 랜덤 숫자 선정
    
    var myNumber: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1.mainLabel에 "선택하세요"를 표시
        mainLabel.text = "숫자를 선택하세요"
        //2.numberLabel에 ""을 표시
        numberLabel.text = ""
        
    }
    
    
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        //1.버튼의 숫자를 가져와야함
        let numString = sender.currentTitle!
        //2.numberLabel에 숫자를 표시
        numberLabel.text = numString
        //3.선택한 숫자를 변수에다가 저장 (선택사항)
        myNumber = Int(numString)!
        
    }
    
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        //숫자 선택 유도하기
        if myNumber == 0 {
            let alert = UIAlertController(title: "알림", message: "숫자를 먼저 선택해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
        
        
        //1.컴퓨터의 숫자와 내가 선택한 숫자를 비교 Up / Down / Bingo (메인 레이블)
        if comNumber > myNumber {
            mainLabel.text = "Up"
        } else if comNumber < myNumber {
            mainLabel.text = "Down"
        } else {
            mainLabel.text = "Bingo!!🥳🪭"
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        //1.메인레이블 "선택하세요" 표시
        mainLabel.text = "숫자를 선택하세요"
        //2.컴퓨터의 랜덤숫자를 다시 선정
        comNumber = Int.random(in: 1...10)
        //3.숫자레이블을 "" (빈 문자열)
        numberLabel.text = ""
        
        myNumber = 0
    }
    
    


}


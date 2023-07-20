//
//  ViewController.swift
//  RPSGame
//
//  Created by 권대윤 on 2023/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    //변수 / 속성
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var comImageView: UIImageView!
    @IBOutlet var myImageView: UIImageView!
    
    @IBOutlet var comChoiceLabel: UILabel!
    @IBOutlet var myChoiceLabel: UILabel!
    
    @IBOutlet var scissorsButton: UIButton!
    @IBOutlet var rockButton: UIButton!
    @IBOutlet var paperButton: UIButton!
    
    
    var myChoice: Rps = Rps.none
    
    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    

    //함수 / 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        // [1] 첫번째/두번째 이미지뷰에 준비(묵) 이미지를 띄워야 함
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        // [2] 첫번째/두번째 레이블에 준비 문자열을 띄워야 함
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
        
        
    }
    
    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        //가위바위보를 선택해서 그 정보를 저장해야됨
        let title = sender.currentTitle!
        
        switch title {
        case "가위":
            myChoice = Rps.scissors
            scissorsButton.isSelected = true
            rockButton.isSelected = false
            paperButton.isSelected = false
        case "바위":
            myChoice = Rps.rock
            scissorsButton.isSelected = false
            rockButton.isSelected = true
            paperButton.isSelected = false
        case "보":
            myChoice = Rps.paper
            scissorsButton.isSelected = false
            rockButton.isSelected = false
            paperButton.isSelected = true
        default:
            break
        }
        
        
        
    }
    
    
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        //미선택에 대한 알림 전달하기
        if myChoice == .none {
            let alert = UIAlertController(title: "알림", message: "가위/바위/보 중 하나를 선택해주세요", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
        
        //[1] 컴퓨터가 랜덤 선택한 것을 이미지 뷰에 표시
        //[2] 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        switch comChoice {
        case .rock:
            comImageView.image = #imageLiteral(resourceName: "rock")
            comChoiceLabel.text = "바위"
        case .paper:
            comImageView.image = #imageLiteral(resourceName: "paper")
            comChoiceLabel.text = "보"
        case .scissors:
            comImageView.image = #imageLiteral(resourceName: "scissors")
            comChoiceLabel.text = "가위"
        case .none:
            break
        }
        
        //[3] 내가 선택한 것을 이미지뷰에 표시
        //[4] 내가 선택한 것을 레이블에 표시
        switch myChoice {
        case .rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case .paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        case .scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        case .none:
            break
        }
        
        
        //컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 승패를 레이블에 표시
        if comChoice == myChoice {
            mainLabel.text = "무승부!"
        } else if comChoice == .rock && myChoice == .paper || comChoice == .paper && myChoice == .scissors || comChoice == .scissors && myChoice == .rock {
            mainLabel.text = "승리!"
        } else {
            mainLabel.text = "패배!"
        }
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        //[1] 컴퓨터 - 준비상태를 이미지 뷰에 표시
        //[2] 컴퓨터 - 준비상태를 레이블에 표시
        comImageView.image = #imageLiteral(resourceName: "ready")
        comChoiceLabel.text = "준비"
        
        //[3] 나 - 준비상태를 이미지뷰에 표시
        //[4] 나 - 준비상태를 레이블에 표시
        myImageView.image = #imageLiteral(resourceName: "ready")
        myChoiceLabel.text = "준비"
        
        //메인 레이블에 준비상태를 레이블에 표시
        mainLabel.text = "선택하세요"
        
        //컴퓨터가 다시 랜덤 가위바위보를 선택하고 저장
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
        
        //나 - 다시 가위바위보 선택 정보 초기화
        myChoice = Rps.none
        
        //버튼 선택상태 해제
        scissorsButton.isSelected = false
        rockButton.isSelected = false
        paperButton.isSelected = false
    }
    

}




//
//  ViewController.swift
//  TimerApp
//
//  Created by 권대윤 on 2023/07/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
        timer?.invalidate()
        number = 0
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        //슬라이더의 벨류값을 가지고 메인레이블의 텍스트를 셋팅
        number = Int(sender.value * 60)
        
        mainLabel.text = "\(number)초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        //1초씩 지나갈때마다 무언가를 실행
        timer?.invalidate()
        
        //셀렉터를 사용한 방식
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        
        
        //클로저를 사용한 방식
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {[self] _ in
//            //반복을 하고 싶은 코드
//            if number > 0 {
//                number -= 1
//                slider.value = Float(number) / Float(60)
//                mainLabel.text = "\(number)초"
//            } else {
//                number = 0
//                mainLabel.text = "초를 선택하세요"
//                timer?.invalidate()
//                //소리를 나게함
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//            }
//
//        })
        
        
    }

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        //초기화 셋팅
        configureUI()
    }
    
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number)초"
        } else {
            number = 0
            mainLabel.text = "초를 선택하세요"
            timer?.invalidate()
            //소리를 나게함
            AudioServicesPlayAlertSound(SystemSoundID(1322))
        }
    }
    
    
    
    
    
    
}


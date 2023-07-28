//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by 권대윤 on 2023/07/28.
//

import UIKit

//BMI와 관련된 비즈니스 로직과 관련된 모든 코드를 담아둔 모델
class BMICalculatorManager {
    
    private var bmiResultValue: BMI?
    

    
    func getBMIResult(height: String, weight: String) -> BMI {
        calculateBMI(height: height, weight: weight)
        
        return bmiResultValue ?? BMI(value: 0.0, matchColor: .white, advice: "문제발생")
    }
    
    //bmi 계산하는 메서드
    private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height),
              let w = Double(weight) else {
            bmiResultValue = BMI(value: 0.0, matchColor: .white, advice: "문제발생")
            return
        }
        
        var bmi = w / (h * h) * 10000
        print(bmi)
        bmi = round(bmi * 100) / 100
        
        switch bmi {
        case ..<18.6:
            let color = UIColor(red: 0.95, green: 0.99, blue: 0.53, alpha: 1.00)
            bmiResultValue = BMI(value: bmi, matchColor: color, advice: "저체중")
        case 18.6..<23.0:
            let color = UIColor(red: 0.60, green: 0.99, blue: 0.53, alpha: 1.00)
            bmiResultValue = BMI(value: bmi, matchColor: color, advice: "표준")
        case 23.0..<25.0:
            let color = UIColor(red: 0.75, green: 0.33, blue: 0.67, alpha: 1.00)
            bmiResultValue = BMI(value: bmi, matchColor: color, advice: "과체중")
        case 25.0..<30.0:
            let color = UIColor(red: 1.00, green: 0.56, blue: 0.56, alpha: 1.00)
            bmiResultValue = BMI(value: bmi, matchColor: color, advice: "중도비만")
        case 30.0...:
            let color = UIColor(red: 0.98, green: 0.22, blue: 0.22, alpha: 1.00)
            bmiResultValue = BMI(value: bmi, matchColor: color, advice: "고도비만")
        default:
            return bmiResultValue = BMI(value: 0.0, matchColor: .white, advice: "문제발생")
        }
        
    }
    
    
    
    
}

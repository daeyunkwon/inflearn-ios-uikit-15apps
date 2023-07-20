//
//  ViewController.swift
//  DiceGame
//
//  Created by 권대윤 on 2023/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    var imageArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    
    @IBOutlet var leftDiceImageView: UIImageView!
    @IBOutlet var rightDiceImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //leftDiceImageView.image = imageArray[0]
        //rightDiceImageView.image = imageArray[0]
        
    }

    
    
    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        
        //왼쪽 이미지 뷰의 이미지를 랜덤으로 변경
        leftDiceImageView.image = imageArray.randomElement()
        
        //오른쪽 이미지 뷰의 이미지를 랜덤으로 변경
        rightDiceImageView.image = imageArray.randomElement()
        
    }
    

    
    
    
}


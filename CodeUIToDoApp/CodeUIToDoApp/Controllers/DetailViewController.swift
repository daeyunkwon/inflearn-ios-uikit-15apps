//
//  DetailViewController.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let detailVC = DetailView()
    
    private let coreDataManager = CoreDataManager.shared
    
    private var temporaryNumber: Int64? = 1
    
    var toDoData: ToDoData? {
        didSet {
            temporaryNumber = toDoData?.color
        }
    }
    
    
    override func loadView() {
        super.loadView()
        self.view = detailVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        configureUI()
    }
    
    func setup() {
        detailVC.memoTextLabel.delegate = self
        
        detailVC.buttonArrays.forEach { button in
            button.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        }
        
        detailVC.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureUI() {
        
        if let toDoData {
            self.title = "수정하기"
            detailVC.memoTextLabel.text = toDoData.todoText
            detailVC.saveButton.setTitle("UPDATE", for: .normal)
            
            guard let color = MyColor(rawValue: toDoData.color) else {return}
            detailVC.backView.backgroundColor = color.backgoundColor
            detailVC.saveButton.backgroundColor = color.buttonColor
            
            
        } else {
            self.title = "새로운 메모 생성하기"
            
            detailVC.memoTextLabel.text = "텍스트를 여기에 입력하세요."
            detailVC.memoTextLabel.textColor = .lightGray
            detailVC.saveButton.setTitle("SAVE", for: .normal)
            
            detailVC.backView.backgroundColor = MyColor.red.backgoundColor
            detailVC.saveButton.backgroundColor = MyColor.red.buttonColor
        }
        
        clearButtonColors()
        setupColorButton(num: toDoData?.color ?? 1)
        
    }
    
    
    
    func clearButtonColors() {
        detailVC.redButton.backgroundColor = MyColor.red.backgoundColor
        detailVC.redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        detailVC.greenButton.backgroundColor = MyColor.green.backgoundColor
        detailVC.greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        detailVC.blueButton.backgroundColor = MyColor.blue.backgoundColor
        detailVC.blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        detailVC.purpleButton.backgroundColor = MyColor.purple.backgoundColor
        detailVC.purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            detailVC.redButton.backgroundColor = MyColor.red.buttonColor
            detailVC.redButton.setTitleColor(.white, for: .normal)
        case 2:
            detailVC.greenButton.backgroundColor = MyColor.green.buttonColor
            detailVC.greenButton.setTitleColor(.white, for: .normal)
        case 3:
            detailVC.blueButton.backgroundColor = MyColor.blue.buttonColor
            detailVC.blueButton.setTitleColor(.white, for: .normal)
        case 4:
            detailVC.purpleButton.backgroundColor = MyColor.purple.buttonColor
            detailVC.purpleButton.setTitleColor(.white, for: .normal)
        default:
            detailVC.redButton.backgroundColor = MyColor.red.buttonColor
            detailVC.redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    @objc func colorButtonTapped(_ sender: UIButton) {
        self.temporaryNumber = Int64(sender.tag)
        
        clearButtonColors()
        setupColorButton(num: Int64(sender.tag))
        
        guard let color = MyColor(rawValue: Int64(sender.tag)) else {return}
        
        detailVC.backView.backgroundColor = color.backgoundColor
        detailVC.saveButton.backgroundColor = color.buttonColor
    }
    
    @objc func saveButtonTapped() {
        if let toDoData {
            toDoData.todoText = detailVC.memoTextLabel.text
            toDoData.color = temporaryNumber ?? 1
            
            coreDataManager.updateToDoDataFromCoreData(newToDoData: toDoData) {
                print("수정 완료")
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            coreDataManager.saveToDoDataInCoreData(memoText: detailVC.memoTextLabel.text, colorInt: temporaryNumber ?? 1) {
                print("저장 완료")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}

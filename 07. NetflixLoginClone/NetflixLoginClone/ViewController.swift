//
//  ViewController.swift
//  NetflixLoginClone
//
//  Created by 권대윤 on 2023/07/26.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    //"이메일 또는 전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = .systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    //로그인 - 이메일 입력 텍스트필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    //MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    //패스워드 텍스트필드의 안내문구
    private var passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    //로그인 - 비밀번호 입력 텍스트필드
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    //패스워드에 "표시" 버튼(비밀번호 가리기 기능)
    private lazy var passwordSecureButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("표시", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - 로그인 버튼
    private let loginButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        btn.setTitle("로그인", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - 스택뷰
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()
    
    //MARK: - 비밀번호 재설정 버튼
    private lazy var passwordResetButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("비밀번호 재설정", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    //3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    //오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
    }
    
    
    
    func makeUI() {
        view.backgroundColor = .black
        
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
    
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        //'isActive = true'가 귀찮다면 사용하는 방식
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            //emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor, constant: 0)
            emailInfoLabelCenterYConstraint
        ])
        
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2).isActive = true
        
        
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8).isActive = true
        passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8).isActive = true
        //passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor, constant: 0).isActive = true
        passwordInfoLabelCenterYConstraint.isActive = true
        
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8).isActive = true
        
        
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15).isActive = true
        passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15).isActive = true
        passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8).isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36).isActive = true
        
        
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        
    }
    
    
    @objc func resetButtonTapped() {
        let alert = UIAlertController(title: "비밀번호 재설정", message: "비밀번호를 변경하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default){action in
            print("확인 버튼이 눌렸습니다.")
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel){cancel in
            print("취소 버튼이 눌렸습니다.")
        })
        present(alert, animated: true, completion: {
            print("완료되었음")
        })
    }
    
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func loginButtonTapped() {
        print("로그인 버튼이 눌렸습니다.")
    }
    


}

//MARK: - UITextFieldDelegate 메서드
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            emailInfoLabel.font = .systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            passwordInfoLabel.font = .systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        //내부에 있는 모든 것을 자연스럽게 이동하는 것으로 보이기 위한 코드: 0.3초동안 애니메이션이 나타남
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            
            if emailTextField.text == "" {
                emailInfoLabel.font = .systemFont(ofSize: 18)
                //오토레이아웃 업데이트
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)

            if passwordTextField.text == "" {
                passwordInfoLabel.font = .systemFont(ofSize: 18)
                //오토레이아웃 업데이트
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        //내부에 있는 모든 것을 자연스럽게 이동하는 것으로 보이기 위한 코드: 0.3초동안 애니메이션이 나타남
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    
    
    
    
}

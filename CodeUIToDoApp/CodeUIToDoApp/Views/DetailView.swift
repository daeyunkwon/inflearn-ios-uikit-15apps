//
//  DetailView.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//

import UIKit

final class DetailView: UIView {
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Red", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.tag = 1
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Green", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.tag = 2
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Blue", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.tag = 3
        return button
    }()
    
    let purpleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Purple", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.tag = 4
        return button
    }()
    
    lazy var buttonArrays: [UIButton] = [redButton, greenButton, blueButton, purpleButton]
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton, purpleButton])
        sv.axis = .horizontal
        sv.spacing = 15
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.addSubview(memoTextLabel)
        return view
    }()
    
    let memoTextLabel: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 14)
        tv.backgroundColor = .clear
        return tv
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.tintColor = .white
        return button
    }()
    
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.backgroundColor = .white
        
        self.addSubview(stackView)
        self.addSubview(backView)
        self.addSubview(saveButton)
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        redButton.translatesAutoresizingMaskIntoConstraints = false
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        memoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            
            redButton.widthAnchor.constraint(equalToConstant: 50),
            redButton.heightAnchor.constraint(equalToConstant: 35),
            
            backView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            backView.heightAnchor.constraint(equalToConstant: 200),
            
            memoTextLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            memoTextLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8),
            memoTextLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            memoTextLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            
            saveButton.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
    
    
    
    
    
    
    
}

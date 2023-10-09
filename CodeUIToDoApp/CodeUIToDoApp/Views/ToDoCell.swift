//
//  ToDoCell.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//

import UIKit

final class ToDoCell: UITableViewCell {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.addSubview(stackView)
        return view
    }()
    
    private let memoTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var basicView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(dateLabel)
        view.addSubview(updateButton)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPDATE", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 9)
        button.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [memoTextLabel, basicView])
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    var updateButtonPressed: ((ToDoCell) -> Void) = {sender in}
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.contentView.addSubview(backView)
    }
    
    func setupConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        memoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        basicView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            
            memoTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            basicView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 1),
            dateLabel.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -1),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            
            updateButton.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 0),
            updateButton.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: 0),
            updateButton.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: 0),
            updateButton.widthAnchor.constraint(equalToConstant: 100)
            
            
        ])
        
        
        basicView.setContentHuggingPriority(.init(251), for: .vertical)
        
        memoTextLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        
    }
    
    
    
    
    
    
    
    
    
    private func configureUIwithData() {
        memoTextLabel.text = toDoData?.todoText
        dateLabel.text = toDoData?.dateString
        
        backView.backgroundColor = MyColor(rawValue: toDoData?.color ?? 1)?.backgoundColor
        updateButton.backgroundColor = MyColor(rawValue: toDoData?.color ?? 1)?.buttonColor
    }
    
    
    
    @objc func updateButtonTapped() {
        updateButtonPressed(self)
    }
    
    
    
    

}

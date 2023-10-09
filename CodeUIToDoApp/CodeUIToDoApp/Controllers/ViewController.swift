//
//  ViewController.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let coreDataManager = CoreDataManager.shared
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupTableViewConstraints()
        setupNavi()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.separatorStyle = .none
    }
    
    func setupTableViewConstraints() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func setupNavi() {
        self.title = "ToDoList"
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = .init(style: .light)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
    
    
    
    


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.getToDoDataFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.toDoData = coreDataManager.getToDoDataFromCoreData()[indexPath.row]
        
        cell.updateButtonPressed = {[weak self] senderCell in
            let detailVC = DetailViewController()
            detailVC.toDoData = senderCell.toDoData
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


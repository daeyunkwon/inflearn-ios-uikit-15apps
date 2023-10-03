//
//  ViewController.swift
//  MusicApp
//
//  Created by 권대윤 on 2023/09/22.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let musicManager = MusicManager.shared
    
    let searchController = UISearchController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicManager.checkWhetherSaved()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupNavi()
        setupSearchBar()
        setupDatas()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        tableView.separatorStyle = .none
    }
    
    func setupNavi() {
        self.title = "Music Search"
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
    }
    
    func setupDatas() {
        musicManager.setupMusicFromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func makeSaveAlert(completion: @escaping (String?, Bool) -> Void) {
        let alert = UIAlertController(title: "좋아하는 음악 목록에 저장", message: "음악과 함께 저장할 문구를 입력하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "저장할려는 내용"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { okAction in
            let saveText = alert.textFields?[0].text
            completion(saveText, true)
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { cancelAction in
            completion(nil, false)
        }))
        
        self.present(alert, animated: true)
    }
    
    func makeRemoveCheckAlert(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "좋아하는 음악 목록에서 삭제", message: "정말 좋아하는 음악 목록에서 삭제하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { okAction in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { cancelAction in
            completion(false)
        }))
        
        self.present(alert, animated: true)
    }
    
    


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getMusicArrays().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        
        let music = musicManager.getMusicArrays()[indexPath.row]
        cell.music = music
        
        cell.saveButtonPressed = {[weak self] senderCell, isSaved in
            guard let self else {return}
            guard let senderCellMusic = senderCell.music else {return}
            
            if !isSaved {
                self.makeSaveAlert { saveText, okAction in
                    if okAction {
                        self.musicManager.saveMusicInCoreData(with: senderCellMusic, message: saveText) {
                            senderCellMusic.isSaved = true
                            cell.setButtonStatus()
                            print("좋아하는 음악 목록에 저장 완료")
                        }
                    } else {
                        print("취소됨")
                    }
                }
            } else {
                self.makeRemoveCheckAlert { okAction in
                    if okAction {
                        self.musicManager.deleteMusic(with: senderCellMusic) {
                            senderCellMusic.isSaved = false
                            cell.setButtonStatus()
                            print("좋아하는 음악 목록에서 삭제 완료")
                        }
                    } else {
                        print("취소됨")
                    }
                }
            }
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        print("검색 키워드: \(text)")
        
        musicManager.fetchMusicFromAPI(searchTerm: text) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text = searchText.lowercased()
    }
    
    
}


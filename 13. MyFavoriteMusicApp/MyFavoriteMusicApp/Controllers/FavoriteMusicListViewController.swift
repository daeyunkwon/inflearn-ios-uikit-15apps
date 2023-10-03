//
//  FavoriteMusicListViewController.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/03.
//

import UIKit

final class FavoriteMusicListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let musicManager = MusicManager.shared
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupNavi()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FavoriteMusicCell", bundle: nil), forCellReuseIdentifier: "FavoriteMusicCell")
        tableView.separatorStyle = .none
    }
    
    func setupNavi() {
        self.title = "Favorite Music List"
    }
    
    func makeRemoveCheckAlert(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "좋아하는 음악 목록에서 제거", message: "좋아하는 음악 목록에서 선택한 음악을 제거하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { okAction in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { cancelAction in
            completion(false)
        }))
        
        self.present(alert, animated: true)
    }
    
    func makeUpdateAlert(currentMessage: String?, completion: @escaping (String?, Bool) -> Void) {
        let alert = UIAlertController(title: "내용 수정", message: "음악과 함께 저장할 문구를 입력하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = currentMessage
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
    
    
    
    
    

}

extension FavoriteMusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getMusicSavedArrays().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMusicCell", for: indexPath) as! FavoriteMusicCell
        
        let musicSaved = musicManager.getMusicSavedArrays()[indexPath.row]
        cell.musicSaved = musicSaved
        
        cell.saveButtonPressed = {[weak self] senderCell in
            guard let self else {return}
            guard let senderCellMusicSaved = senderCell.musicSaved else {return}
            
            self.makeRemoveCheckAlert { okAction in
                if okAction {
                    self.musicManager.deleteMusicFromCoreData(with: senderCellMusicSaved) {
                        self.tableView.reloadData()
                        print("음악 삭제 후 테이블뷰 리로드 완료")
                    }
                } else {
                    print("취소됨")
                }
            }
        }
        
        cell.updateButtonPressed = {[weak self] senderCell, message in
            guard let self else {return}
            guard let senderCellMusicSaved = senderCell.musicSaved else {return}
            
            self.makeUpdateAlert(currentMessage: message) { saveText, okAction in
                if okAction {
                    senderCellMusicSaved.myMessage = saveText
                    self.musicManager.updateMusicFromCoreData(with: senderCellMusicSaved) {
                        tableView.reloadData()
                        print("코멘트 업데이트 후 테이블뷰 리로드 완료")
                    }
                } else {
                    print("취소됨")
                }
            }
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension FavoriteMusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  ViewController.swift
//  MusicSearchApp
//
//  Created by 권대윤 on 2023/09/06.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    //네트워크 매니저(싱글톤)
    let networkManager = NetworkManager.shared
    
    //음악 데이터를 담을 빈 배열
    var musicArray: [Music] = []
    
    let searchController = UISearchController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
        setupTitle()
        setupTableView()
    }
    
    //데이터 셋업
    func setupData() {
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            switch result {
            case Result.success(let musicDatas):
                self.musicArray = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //타이틀 셋업
    func setupTitle() {
        self.title = "Music"
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let myShadowAttributes = NSShadow()
        myShadowAttributes.shadowOffset = CGSize(width: 1, height: 1)
        myShadowAttributes.shadowColor = #colorLiteral(red: 0, green: 0.4616305828, blue: 0.9777315259, alpha: 1)
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.shadow : myShadowAttributes]
        
    }
    
    
    //테이블뷰 셋업
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        //nib파일로 만든 셀 등록하기
        musicTableView.register(UINib.init(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
    }
    
    
    


}



//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        
        cell.imageUrl = musicArray[indexPath.row].imageUrl //속도를 위해서 이미지의 url만 넘겨주기
        cell.songNameLabel.text = musicArray[indexPath.row].songName
        cell.artistNameLabel.text = musicArray[indexPath.row].artistName
        cell.albumNameLabel.text = musicArray[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArray[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}


//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    //셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        
        musicArray = []
        
        networkManager.fetchMusic(searchTerm: text) { result in
            switch result {
            case Result.success(let musicDatas):
                self.musicArray = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

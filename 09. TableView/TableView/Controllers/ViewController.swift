//
//  ViewController.swift
//  TableView
//
//  Created by 권대윤 on 2023/08/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //var movieArray: [Movie] = []
    
    var movieDataManager = DataManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //셀의 각 행 높이 설정
        tableView.rowHeight = 120
        
        movieDataManager.makeMovieData()
        //movieArray = movieDataManager.getMovieData()
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData()
        tableView.reloadData()
    }
    

}


//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        
        return movieDataManager.getMovieData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movieArray = movieDataManager.getMovieData()
        
        cell.mainImageView.image = movieArray[indexPath.row].movieImage
        cell.movieNameLabel.text = movieArray[indexPath.row].movieName
        cell.descriptionLabel.text = movieArray[indexPath.row].movieDescription
        //선택 스타일
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    
}



//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "toDetail", sender: indexPath) //indexPath 데이터 전달함
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            guard let detailVC = segue.destination as? DetailViewController else {return}
            
            guard let indexPath = sender as? IndexPath else {return}
            
            let array = movieDataManager.getMovieData()
            detailVC.movieData = array[indexPath.row]
        }
        
        
    }
    
    
    
    
}

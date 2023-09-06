//
//  MusicCell.swift
//  MusicSearchApp
//
//  Created by 권대윤 on 2023/09/06.
//

import UIKit

class MusicCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var albumNameLabel: UILabel!

    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var imageUrl: String? {
        didSet { //속성에 담긴 값 변경될 시 loadImage() 함수 실행
            loadImage()
        }
    }
    
    //셀 재사용 전 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil //이미지 표시 없음 처리
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //이미지 url => Data => UIImage으로 만들기
    func loadImage() {
        guard let urlString = imageUrl else {return}
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
}

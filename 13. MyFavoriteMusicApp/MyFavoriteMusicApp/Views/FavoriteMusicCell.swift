//
//  FavoriteMusicCell.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/03.
//

import UIKit

final class FavoriteMusicCell: UITableViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var savedDateLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    var saveButtonPressed: ((FavoriteMusicCell) -> Void) = {sender in}
    
    var updateButtonPressed: ((FavoriteMusicCell, String?) -> Void) = {sender, text in}
    
    
    var musicSaved: MusicSaved? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 8
        
        saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        saveButton.tintColor = #colorLiteral(red: 1, green: 0.3850526512, blue: 0.6862640977, alpha: 1)
    }
    
    func configureUIwithData() {
        loadImage(imageUrl: musicSaved?.imageUrl)
        
        songNameLabel.text = musicSaved?.songName
        artistNameLabel.text = musicSaved?.artistName
        albumNameLabel.text = musicSaved?.albumName
        releaseDateLabel.text = "음원 발매일: " + (musicSaved?.releaseDate ?? "")
        savedDateLabel.text = "저장일: " + (musicSaved?.saveDateString ?? "")
        commentLabel.text = musicSaved?.myMessage
    }
    
    func loadImage(imageUrl: String?) {
        guard let urlString = imageUrl else {return}
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveButtonPressed(self)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        updateButtonPressed(self, musicSaved?.myMessage)
    }
    
    
}

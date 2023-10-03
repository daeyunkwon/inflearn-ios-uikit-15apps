//
//  MusicCell.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/02.
//

import UIKit

final class MusicCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var saveButton: UIButton!
    
    var saveButtonPressed: ((MusicCell, Bool) -> Void) = {sender, pressed in}
    
    var music: Music? {
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
    }
    
    func configureUIwithData() {
        loadImage(imageUrl: music?.imageUrl)
        setButtonStatus()
        
        songNameLabel.text = music?.songName
        artistNameLabel.text = music?.artistName
        albumNameLabel.text = music?.albumName
        releaseDateLabel.text = "음원 발매일: " + (music?.releaseDateString ?? "")
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
    
    func setButtonStatus() {
        guard let isSaved = music?.isSaved else {return}
        
        if isSaved {
            saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            saveButton.tintColor = #colorLiteral(red: 1, green: 0.3850526512, blue: 0.6862640977, alpha: 1)
        } else {
            saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
            saveButton.tintColor = .gray
        }
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let isSaved = music?.isSaved else {return}
        
        saveButtonPressed(self, isSaved)
    }
}

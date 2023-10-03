//
//  MusicManager.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/02.
//

import UIKit
import CoreData

final class MusicManager {
    
    static let shared = MusicManager()
    private init() {
        fetchMusicSavedFromCoreData {
            print("코어데이터로부터 저장된 데이터셋팅 완료")
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    private let coreDataManager = CoreDataManager.shared
    
    private var musicArrays: [Music] = []
    
    private var musicSavedArrays: [MusicSaved] = []
    
    
    
    func getMusicArrays() -> [Music] {
        return musicArrays
    }
    
    func getMusicSavedArrays() -> [MusicSaved] {
        return musicSavedArrays
    }
    
    
    
    //MARK: - Mathod for Communication with API
    
    func setupMusicFromAPI(completion: @escaping () -> Void) {
        getMusicFromAPI(searchTerm: "beenzino") {
            completion()
        }
    }
    
    func fetchMusicFromAPI(searchTerm: String, completion: @escaping () -> Void) {
        getMusicFromAPI(searchTerm: searchTerm) {
            completion()
        }
    }
    
    private func getMusicFromAPI(searchTerm: String, completion: @escaping () -> Void) {
        networkManager.fetchMusic(searchTerm: searchTerm) { result in
            switch result {
            case .success(let musics):
                self.musicArrays = musics
                self.checkWhetherSaved()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                self.checkWhetherSaved()
                completion()
            }
        }
    }
    
    func checkWhetherSaved() {
        musicArrays.forEach { music in
            if musicSavedArrays.contains(where: {
                $0.songName == music.songName && $0.artistName == music.artistName
            }) {
                music.isSaved = true
            } else {
                music.isSaved = false
            }
        }
    }
    
    
    //MARK: - Method for Communication with CoreData
    
    private func fetchMusicSavedFromCoreData(completion: @escaping () -> Void) {
        musicSavedArrays = coreDataManager.getMusicSavedDatasFromCoreData()
        completion()
    }
    
    func saveMusicInCoreData(with music: Music, message: String?, completion: @escaping () -> Void) {
        coreDataManager.saveMusicDataInCoreData(with: music, message: message) {
            self.fetchMusicSavedFromCoreData {
                completion()
            }
        }
    }
    
    func deleteMusicFromCoreData(with musicSaved: MusicSaved, completion: @escaping () -> Void) {
        coreDataManager.deleteMusicSavedDataFromCoreData(musicSaved: musicSaved) {
            self.fetchMusicSavedFromCoreData {
                completion()
            }
        }
    }
    
    func deleteMusic(with music: Music, completion: @escaping () -> Void) {
        let musicSaved = musicSavedArrays.filter {
            $0.songName == music.songName && $0.artistName == music.artistName
        }
        
        if let target = musicSaved.first {
            deleteMusicFromCoreData(with: target) {
                print("삭제 완료")
                completion()
            }
        } else {
            print("삭제할 해당 데이터는 존재하지 않음")
            completion()
        }
    }
    
    func updateMusicFromCoreData(with newMusicSaved: MusicSaved, completion: @escaping () -> Void) {
        coreDataManager.updateMusicSavedDataFromCoreData(newMusicSaved: newMusicSaved) {
            self.fetchMusicSavedFromCoreData {
                completion()
            }
        }
    }
    
    
    
    
    
    
    
    
}

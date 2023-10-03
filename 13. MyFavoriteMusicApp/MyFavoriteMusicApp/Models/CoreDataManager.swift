//
//  CoreDataManager.swift
//  MyFavoriteMusicApp
//
//  Created by 권대윤 on 2023/10/02.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    private let myEntityName = "MusicSaved"
    
    
    //CoreData - Read
    func getMusicSavedDatasFromCoreData() -> [MusicSaved] {
        var musicSaveds: [MusicSaved] = []
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            let dataOrder = NSSortDescriptor(key: "saveDate", ascending: false)
            request.sortDescriptors = [dataOrder]
            
            do {
                if let fetchMusicSavedList = try context.fetch(request) as? [MusicSaved] {
                    musicSaveds = fetchMusicSavedList
                }
            } catch {
                print("Read failed")
            }
        }
        return musicSaveds
    }
    
    
    //CoreData - Create
    func saveMusicDataInCoreData(with music: Music, message: String?, completion: @escaping () -> Void) {
        if let context {
            if let entity = NSEntityDescription.entity(forEntityName: self.myEntityName, in: context) {
                if let musicSaved = NSManagedObject(entity: entity, insertInto: context) as? MusicSaved {
                    musicSaved.songName = music.songName
                    musicSaved.artistName = music.artistName
                    musicSaved.albumName = music.albumName
                    musicSaved.releaseDate = music.releaseDateString
                    musicSaved.imageUrl = music.imageUrl
                    musicSaved.previewUrl = music.previewUrl
                    musicSaved.myMessage = message
                    musicSaved.saveDate = Date()
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
    
    //CoreData - Delete
    func deleteMusicSavedDataFromCoreData(musicSaved: MusicSaved, completion: @escaping () -> Void) {
        guard let date = musicSaved.saveDate else {
            completion()
            return
        }
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            request.predicate = NSPredicate(format: "saveDate = %@", date as CVarArg)
            do {
                if let fetchMusicSavedList = try context.fetch(request) as? [MusicSaved] {
                    if let targetMusicSavedData = fetchMusicSavedList.first {
                        context.delete(targetMusicSavedData)
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("Delete failed")
                completion()
            }
        }
    }
    
    
    //CoreData - Update
    func updateMusicSavedDataFromCoreData(newMusicSaved: MusicSaved, completion: @escaping () -> Void) {
        guard let date = newMusicSaved.saveDate else {
            completion()
            return
        }
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            request.predicate = NSPredicate(format: "saveDate = %@", date as CVarArg)
            do {
                if let fetchMusicSavedList = try context.fetch(request) as? [MusicSaved] {
                    if var targetMusicSavedData = fetchMusicSavedList.first {
                        targetMusicSavedData = newMusicSaved
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("Update failed")
                completion()
            }
        }
    }
    
    
    
    
    
    
}

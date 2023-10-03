//
//  MusicSaved+CoreDataProperties.swift
//  MusicApp
//
//  Created by 권대윤 on 2023/09/22.
//
//

import Foundation
import CoreData


extension MusicSaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicSaved> {
        return NSFetchRequest<MusicSaved>(entityName: "MusicSaved")
    }

    @NSManaged public var songName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var albumName: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var saveDate: Date?
    @NSManaged public var myMessage: String?
    
    var saveDateString: String? {
        let myFormatter = DateFormatter()
        
        myFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = self.saveDate else {return ""}
        let dateString = myFormatter.string(from: date)
        
        return dateString
    }

}

extension MusicSaved : Identifiable {

}

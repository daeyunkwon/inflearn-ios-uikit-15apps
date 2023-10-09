//
//  ToDoData+CoreDataProperties.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var todoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.locale = Locale(identifier: "ko_KR")
        myFormatter.dateFormat = "yyyy-MM-dd a hh:mm"
        
        guard let date else {return ""}
        let dateString = myFormatter.string(from: date)
        return dateString
    }

}

extension ToDoData : Identifiable {

}

//
//  CoreDataManager.swift
//  test
//
//  Created by 권대윤 on 2023/10/09.
//

import UIKit
import CoreData


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let myEntityName = "ToDoData"
    
    
    func getToDoDataFromCoreData() -> [ToDoData] {
        var toDoArrays: [ToDoData] = []
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            do {
                if let fetchToDoDataArrays = try context.fetch(request) as? [ToDoData] {
                    toDoArrays = fetchToDoDataArrays
                }
            } catch {
                print(#function + "failed!!")
            }
            
        }
        return toDoArrays
    }
    
    
    func saveToDoDataInCoreData(memoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        if let context {
            if let entity = NSEntityDescription.entity(forEntityName: self.myEntityName, in: context) {
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    toDoData.todoText = memoText
                    toDoData.color = colorInt
                    toDoData.date = Date()
                    do {
                        if context.hasChanges {
                            try context.save()
                            completion()
                        }
                    } catch {
                        print(#function + "failed!!")
                    }
                }
            }
        }
        completion()
    }
    
    
    func deleteToDoDataFromCoreData(toDoData: ToDoData, completion: @escaping () -> Void) {
        guard let date = toDoData.date else {
            completion()
            return
        }
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            do {
                if let fetchToDoDataArrays = try context.fetch(request) as? [ToDoData] {
                    if let targetData = fetchToDoDataArrays.first {
                        context.delete(targetData)
                        do {
                            if context.hasChanges {
                                try context.save()
                                completion()
                            }
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
                completion()
            } catch {
                print(#function + "failed!!")
                completion()
            }
        }
    }
    
    
    func updateToDoDataFromCoreData(newToDoData: ToDoData, completion: @escaping () -> Void) {
        guard let date = newToDoData.date else {
            completion()
            return
        }
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.myEntityName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            do {
                if let fetchToDoDataArrays = try context.fetch(request) as? [ToDoData] {
                    if var targetData = fetchToDoDataArrays.first {
                        targetData = newToDoData
                        do {
                            if context.hasChanges {
                                try context.save()
                                completion()
                            }
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
                completion()
            } catch {
                print(#function + "failed!!")
                completion()
            }
        }
    }
    
    
    
    
    
    
}




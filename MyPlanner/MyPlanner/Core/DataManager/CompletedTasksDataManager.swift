//
//  CompletedTasksDataManager.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 28.06.2023.
//

import UIKit
import CoreData

final class CompletedTasksDataManager {
    static let shared = CompletedTasksDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    @discardableResult
    func addCompletedTask(completedTaskName: String, completedType: TaskType) -> CompletedTasks? {
        let entity = NSEntityDescription.entity(forEntityName: "CompletedTasks", in: managedContext)!
        let completedData = NSManagedObject(entity: entity, insertInto: managedContext)
        completedData.setValue(completedTaskName, forKey: "completedTaskName")
        completedData.setValue(completedType.rawValue, forKey: "completedType" )
        
        do {
            try managedContext.save()
            return completedData as? CompletedTasks
        } catch {
            print("Error")
        }
        return nil
    }
    
    func getTasks() -> [CompletedTasks] {
       let fetch = NSFetchRequest<NSManagedObject>(entityName: "CompletedTasks")
        fetch.returnsObjectsAsFaults = false
        do {
            let tasks = try managedContext.fetch(fetch)
            print(tasks)
            return tasks as! [CompletedTasks]
        } catch {
            print("Error")
        }
        return []
    }
    
    func tastCount() -> Int {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "CompletedTasks")
         fetch.returnsObjectsAsFaults = false
         do {
             let tasks = try managedContext.fetch(fetch)
             print(tasks.count)
             return tasks.count
         } catch {
             print("Error")
         }
         return 0
    }
}

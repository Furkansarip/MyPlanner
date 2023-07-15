//
//  ReminderDataManager.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 10.06.2023.
//

import Foundation
import UIKit
import CoreData

final class ReminderDataManager {
    static let shared = ReminderDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    @discardableResult
    func saveReminder(title: String, date: String, reminderType: String, type: String, description: String) -> Reminders? {
        let entity = NSEntityDescription.entity(forEntityName: "Reminders", in: managedContext)!
        let reminderData = NSManagedObject(entity: entity, insertInto: managedContext)
        reminderData.setValue(title, forKey: "rTitle")
        reminderData.setValue(date, forKey: "rDate")
        reminderData.setValue(reminderType, forKey: "rTimeType")
        reminderData.setValue(type, forKey: "rType")
        reminderData.setValue(description, forKey: "rDescription")
        
        do {
           try managedContext.save()
            return reminderData as? Reminders
        } catch {
            print("Error")
        }
        return nil
    }
   
    
    func getReminders() -> [Reminders] {
       let fetch = NSFetchRequest<NSManagedObject>(entityName: "Reminders")
        fetch.returnsObjectsAsFaults = false
        do {
            let reminders = try managedContext.fetch(fetch)
            return reminders as! [Reminders]
        } catch {
            print("Error")
        }
        return []
    }
    
    func deleteReminder(objectID: NSManagedObjectID) {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Reminders")
         fetch.returnsObjectsAsFaults = false
         do {
             let reminders = try managedContext.fetch(fetch)
             for data in reminders {
                 if data.objectID == objectID {
                     managedContext.delete(data)
                 }
             }
             try managedContext.save()
           
         } catch {
             print("Error")
         }
    }
}

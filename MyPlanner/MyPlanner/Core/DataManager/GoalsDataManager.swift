//
//  GoalsDataManager.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 24.06.2023.
//

import UIKit
import CoreData

final class GoalsDataManager {
    static let shared = GoalsDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    @discardableResult
    func saveGoal(title:String, date:String, type:String, description: String) -> Goals? {
        let entity = NSEntityDescription.entity(forEntityName: "Goals", in: managedContext)!
        let goalData = NSManagedObject(entity: entity, insertInto: managedContext)
        goalData.setValue(title, forKey: "gTitle")
        goalData.setValue(date, forKey: "gDate")
        goalData.setValue(type, forKey: "gType")
        goalData.setValue(description, forKey: "gDescription")
        
        do {
           try managedContext.save()
            return goalData as? Goals
        } catch {
            print("Error")
        }
        return nil
    }
   
    
    func getGoals() -> [Goals] {
       let fetch = NSFetchRequest<NSManagedObject>(entityName: "Goals")
        fetch.returnsObjectsAsFaults = false
        do {
            let goals = try managedContext.fetch(fetch)
            return goals as! [Goals]
        } catch {
            print("Error")
        }
        return []
    }
}

//
//  CoreDataAPI.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation
import CoreData

class CoreDataAPI{
    
    lazy var coreDataStack = CoreDataStack()

    func insertChessPlayersData(tableName: String, playersData: [PlayerModal] ){
        let managedContext = coreDataStack.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: tableName)
        //fetchRequest.predicate = NSPredicate(format: "searchkey != nil")
        
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0{
            return
        }
        
        
        for playerObject in playersData{
            let entity = NSEntityDescription.entityForName(tableName, inManagedObjectContext: managedContext)
            let player = ChessPlayers(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            player.name = playerObject.name
            player.currentrating = playerObject.currentRating
            player.lastratings = playerObject.previousRatings
                       
        }
        
        coreDataStack.saveMainContext()

    }
    
    
     func getDataFromEntity(tablename: String) -> [NSManagedObject] {
        
        var arrayResults = [NSManagedObject]()
        let managedContext = coreDataStack.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: tablename)
    
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            arrayResults =  results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return arrayResults
    }
    
    
    func getCountOfPlayers(tablename: String) -> Int{
        
        let managedContext = coreDataStack.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: tablename)
        //fetchRequest.predicate = NSPredicate(format: "searchkey != nil")
        
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0{
            return count
        }
        
        return 0

        
    }


}



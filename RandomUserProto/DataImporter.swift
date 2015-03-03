//
//  DataImporter.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 28/02/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit
import CoreData


@objc protocol DataImportDelegate{
    func importFinished()
}


/// This class is used for importing user profiles to core data.

class DataImporter: NSObject {
    
    var delegate:DataImportDelegate?
    
    /// NSManagedObjectContext
    var context:NSManagedObjectContext
    
    /// RandomUserService
    var service:RandomUserService
    
    /// Initializer
    init(context:NSManagedObjectContext,service:RandomUserService) {
        self.context = context
        self.service = service
    }
    
    // MARK: - Data Import methods
    
    func dataImport() {
        
        let profiles:Array<UserProfile> = Array()
        
        self.service.fetchAllUserProfiles { (profiles) -> Void in
            
            for data in profiles {
                
                let identifier = data.name + data.phone
                
                let randomUser = self.findOrCreateUserProfileWithIdentifier(identifier)
                randomUser.loadDataFromProfile(data)
                
                let errorPointer:NSErrorPointer = nil
                self.context .save(errorPointer)
                
                if (errorPointer != nil) {
                    println("Error:" + errorPointer.debugDescription);
                }
            }
            
            self.delegate?.importFinished()
        }
    }
    
    /**
    
    Returns the user profile if already exists in the core data.
    Otherwise inserts a new row in NSManagedObjectContext
    
    :param: identifier User Identifier
    :return: RandomUserEntity
    
    */
    
    func findOrCreateUserProfileWithIdentifier(identifier:String) -> RandomUserEntity {
        
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "RandomUserEntity")
        fetchRequest.predicate = NSPredicate(format: "identifier=%@", identifier)
        
        let error:NSErrorPointer = NSErrorPointer()
        let result:Array = context.executeFetchRequest(fetchRequest, error:error)!
        
        if (error != nil) {
            println("error - \(error.debugDescription)")
        }
        
        if (result.last != nil) {
            return result.last as RandomUserEntity
        } else {
            let entityDescripition = NSEntityDescription.entityForName("RandomUserEntity", inManagedObjectContext: self.context)
            let randomUser = RandomUserEntity(entity: entityDescripition!, insertIntoManagedObjectContext: self.context)
            randomUser.identifier = identifier;
            return randomUser;
        }
    }
}

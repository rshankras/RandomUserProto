//
//  RandomUserEntity.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 01/03/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import Foundation
import CoreData


/// Generated NSManagedObject class based on RandomUserEntity defined
/// in RandomUser.xcdatamodeld

/// Note :- Any custom function defined in this class will be removed when
/// you regenerate NSManagedObject class.

class RandomUserEntity: NSManagedObject {
    
    // MARK: - Entity Properties
    
    @NSManaged var desc: String
    @NSManaged var identifier: String
    @NSManaged var image: NSData
    @NSManaged var phone: String
    @NSManaged var title: String
    @NSManaged var first: String
    @NSManaged var last: String
    @NSManaged var name: String
    
    // MARK: - Populate Data
    
    func loadDataFromProfile(profile:UserProfile) {
        
        self.title = profile.title
        self.first = profile.firstName
        self.last = profile.lastName
        self.name = profile.name.capitalizedString
        self.phone = profile.phone
        self.desc = profile.description
        
        // convert picture URL to NSData
        
        if let url = NSURL(string: profile.pictureURL) {
            if let data = NSData(contentsOfURL: url) {
                self.image = data
            }
        }
    }
}

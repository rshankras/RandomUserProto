//
//  RandomUserService.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 27/02/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

/// Used for retrieving the data from web service

public class RandomUserService: NSObject {
    
    /// Random user service URL
    
    let serviceURL:String = "http://devzone.ipedis.com/burgermenu/contact.json"
    
    // MARK: Service
    
    /**
    
    Retrieves user profile information from the service.
    
    :return: collection of UserProfiles
    
    */
    
    func fetchAllUserProfiles(completion:(Array<UserProfile>) ->Void)  {
        
        var profiles: Array<UserProfile> = Array()
        
        let url: NSURL =  NSURL(string: serviceURL)!
        
        NSURLSession.sharedSession() .dataTaskWithURL(url, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in

            var errorPointer : NSErrorPointer = nil
            
            if let results: NSArray = NSJSONSerialization .JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments  , error: errorPointer) as? NSArray {

                    for data in results {
                        profiles.append(self.populateData(data as! NSDictionary))
                    }
                    
                    completion(profiles)
            }
        }).resume()
        
    }
    
    /**
    
    Populates user profile information from web service user
    dictionary object.
    
    :param: data NSDictionary
    :return: UserProfile
    
    JSON Structure
    
    "user":{
    "name":{
    "title":,
    "first":"gary",
    "last":"williams"
    },
    "phone":"(282)-558-7525",
    "picture":"http:\/\/randomuser.me\/g\/portraits\/men\/3.jpg",
    "description": "description."
    }
    
    */
    
    func populateData(data:NSDictionary) -> (UserProfile) {
        
        var profile:UserProfile = UserProfile(title: "", firstName: "", lastName: "", pictureURL: "", phone: "", description: "")
        
        var title = ""
        var firstName = ""
        var lastName = ""
        var pictureURL = ""
        var phone = ""
        var description = ""
        
        if let user = data["user"] as? NSDictionary {
            
            if let name = user["name"] as? NSDictionary {
                
                title = self.parseString(name,key: "title")
                firstName = self.parseString(name,key: "first")
                lastName = self.parseString(name,key: "last")
                
            }
            
            phone = self.parseString(user,key: "phone")
            pictureURL = self.parseString(user,key: "picture")
            description = self.parseString(user,key: "description")
            
            profile = UserProfile(title: title, firstName: firstName, lastName: lastName, pictureURL: pictureURL, phone: phone, description: description)
        }
        
        return profile
    }
    
    /**
    
    Retrieves value String values from dictionary object
    
    :param: data NSDictionary
    :return: key Key for which value to be retrieved
    
    */
    
    func parseString(data: NSDictionary, key: String) -> String {
        
        var item = ""
        
        if let temp = data[key] as? String {
            item = temp
        }
        
        return item
    }
}

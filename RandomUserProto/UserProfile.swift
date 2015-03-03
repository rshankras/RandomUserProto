//
//  UserProfile.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 27/02/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

/// Place holder for storing user profile information

struct UserProfile {
    
    /// user's title.
    var title:String
    
    /// user's first name.
    var firstName:String
    
    /// user's last name.
    var lastName:String
    
    /// user's profile picture URL.
    var pictureURL:String
    
    /// user's phone number.
    var phone:String
    
    /// profile description.
    var description:String
    
    /**
    
    Initializes a user profile
    
    :param: title
    :param: first name
    :param: last name
    :param: picture url of the user
    :param: phone
    :param: description
    
    :returns: user profile
    
    */
    
    init(title:String, firstName:String, lastName:String, pictureURL:String, phone:String, description: String)
    {
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.pictureURL = pictureURL
        self.phone = phone
        self.description = description
    }
    
    /// username property
    
    var name: String
        {
        get
        {
            return (title + ". " + firstName + " " + lastName)
        }
    }
}

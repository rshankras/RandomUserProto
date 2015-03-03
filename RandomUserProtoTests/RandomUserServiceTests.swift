//
//  RandomUserServiceTests.swift
//  DeveloperTest
//
//  Created by Ravi Shankar on 28/02/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit
import XCTest

class RandomUserServiceTests: XCTestCase {
    
    var testdata = "{\"user\":{\"name\":{\"title\":\"mr\",\"first\":\"gary\",\"last\":\"williams\"},        \"phone\":\"(282)-558-7525\",\"picture\":\"http:\\/\\/randomuser.me\\/g\\/portraits\\/men\\/3.jpg\",\"description\": \"profile description\"}}"
    
    var emptydata = "{}"
    
    var profile:UserProfile?

    override func setUp() {
        super.setUp()
        
        let service = RandomUserService()
        var data = testdata.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var localError: NSError?
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        if let dict = json as? [String: AnyObject] {
            profile = service.populateData(dict)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNameExistsInUserProfile() {
        XCTAssertEqual(profile!.name, "mr.gary williams", "name exists")
    }
    
    func testURLExistsInUserProfile() {
        XCTAssertEqual(profile!.pictureURL, "http://randomuser.me/g/portraits/men/3.jpg", "URL exists")
    }
    
    func testURLExistsInUserPhone() {
        XCTAssertEqual(profile!.phone, "(282)-558-7525", "phone exists")
    }
    
    func testURLExistsInUserDescription() {
        XCTAssertEqual(profile!.description, "profile description", "description exists")
    }
}

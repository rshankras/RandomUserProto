//
//  ProfileDetailViewController.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 01/03/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController, ENSideMenuDelegate {
    
    var userDetail:RandomUserEntity?
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var photo: UIImageView!
    
    @IBOutlet var phone: UILabel!
    
    @IBOutlet var desc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        applyTextColorStyle()
        
        populateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - PopulateData
    
    func populateData() {
        
        self.name.text = userDetail?.name
        self.desc.text = userDetail?.desc
        self.phone.text = userDetail?.phone
        
        if let imageData = userDetail?.image {
            self.photo.image =  UIImage(data:imageData)
        }
    }
    
    // MARK: - TextColor
    
    func applyTextColorStyle() {
        
        self.name.textColor = getTextColor()
        self.desc.textColor = getTextColor()
        self.phone.textColor = getTextColor()
    }
    
    func getTextColor()->UIColor {
        return UIColor(red: 81.0/255.0, green: 81.0/255.0, blue: 81.0/255.0, alpha: 1.0)
    }
    
    
    // MARK: - SideMenu Methods
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true;
    }
}

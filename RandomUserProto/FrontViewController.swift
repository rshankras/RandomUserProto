//
//  FrontViewController.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 01/03/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

/// This acts as the initial screen for the app displaying side menu.

class FrontViewController: UIViewController, ENSideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - SideMenu
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}

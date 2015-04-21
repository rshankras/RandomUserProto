//
//  SidebarNavigationController.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 01/03/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

/// This is used for implementing SideMenu Navigation

class SidebarNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .loadSideMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - SideMenuNavigation method
    
    func loadSideMenu() {
        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: ContactsViewController(), menuPosition:.Left)
        sideMenu?.menuWidth = 260.0
        //sideMenu?.swipeGestureEnabled = false
        view.bringSubviewToFront(navigationBar)
    }
}

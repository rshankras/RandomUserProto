//
//  ContactsViewController.swift
//  RandomUserProto
//
//  Created by Ravi Shankar on 27/02/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UITableViewController, NSFetchedResultsControllerDelegate, DataImportDelegate {
    
    let CellIdentifier = "UserProfileCell"
    
    let managedObjectContext = CoreDataStack.sharedInstance.managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        loadFetchedResultController()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableView methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        
        if (cell == nil) {
            cell = setupTableViewCell()
        }
        
        if let randomUser = fetchedResultController.objectAtIndexPath(indexPath) as? RandomUserEntity {
            cell?.textLabel?.text = randomUser.name
            cell?.imageView?.image = UIImage(data: randomUser.image)
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var detailViewController : ProfileDetailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileDetailView") as! ProfileDetailViewController
        if let randomUser = fetchedResultController.objectAtIndexPath(indexPath) as? RandomUserEntity {
            detailViewController.userDetail = randomUser
        }
        sideMenuController()?.setContentViewController(detailViewController)
    }
    
    // MARK:- NSFetchedResultsController methods
    
    func getFetchedResultController() -> NSFetchedResultsController {
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: randomUserFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func randomUserFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "RandomUserEntity")
        let sortDescriptor = NSSortDescriptor(key: "first", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView .reloadData()
    }
    
    func loadFetchedResultController() {
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }
    
    // MARK:- Setup View methods
    
    func setupTableView() {
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.scrollsToTop = false
        tableView.separatorStyle = .SingleLine
        tableView.backgroundColor = UIColor.clearColor()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    func setupTableViewCell() -> (UITableViewCell) {
    
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        
        cell.textLabel?.textColor = UIColor(red: 213.0/255.0, green: 223.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        cell.backgroundColor = UIColor.clearColor()
        
        let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height))
        selectedBackgroundView.backgroundColor = UIColor(red: 71.0/255.0, green: 35.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        cell.selectedBackgroundView = selectedBackgroundView
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    // MARK:- Load and import Data
    
    /**
    
    Starts importing and loading data from webservice and
    Core Data
    
    */
    
    func loadData() {
        
        let randomUserService:RandomUserService = RandomUserService()
        let importer:DataImporter = DataImporter(context: managedObjectContext!, service: randomUserService)
        importer.delegate = self
        importer.dataImport()
    }
    
    func importFinished() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
}


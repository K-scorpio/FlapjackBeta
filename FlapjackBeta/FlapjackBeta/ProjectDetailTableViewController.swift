//
//  ProjectDetailTableViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

class ProjectDetailTableViewController: UITableViewController {
    
    
    var project: Project?
    
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.sectionHeaderHeight = 49
        
        // TESTING
        if let project = project {
            CommentController.observeCommentsForProject(project, completion: { (comments) in
                self.comments = comments
                self.tableView.reloadData()
            })
        }
        
        // TODO: Create func/method that will observe messages that belong to the group. Similar to how we observe projects in the ProjectViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        // Configure the cell...
        // TODO: Configure cell with comment
        cell.textLabel?.text = UserController.currentUser?.displayName
        cell.detailTextLabel?.text = "First Comment Test"
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier("headerView") as? CustomHeaderCell ?? CustomHeaderCell()
        
        headerView.fileName.text = self.project?.urlName
        
        return headerView.contentView
    }
    
}

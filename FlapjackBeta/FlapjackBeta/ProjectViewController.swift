//
//  ViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//




// I NEED TO CONFORM TO THE CELLFORROWATINDEXPATH && NUMBEROFROWSINSECTION




import UIKit
import SafariServices
import Firebase

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserController.currentUser != nil {
            return
        } else {
            performSegueWithIdentifier("toLoginView", sender: self)
        }
        
        ProjectController.observeProjects { (projects) in
            self.projects = projects
            // Sort projects in place before reloading table view
            self.myTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        myTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath)        
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.name
        cell.detailTextLabel?.text = project.creator
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as? ProjectDetailTableViewController
        if segue.identifier == "toProjectDetail" {
            guard let indexPath = myTableView.indexPathForSelectedRow else {
                return
            }
            let project = projects[indexPath.row]
            detailVC?.project = project
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
}









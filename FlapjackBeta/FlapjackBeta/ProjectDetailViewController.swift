//
//  ProjectDetailViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 7/14/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import QuickLook
import SwiftyDropbox

class ProjectDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var project: Project?
    
    @IBOutlet weak var messangerTextField: UITextField!
    
    @IBAction func messangerSendButtonTapped(sender: AnyObject) {
        // i want to take messangerTextField.text, set it as a comment using the current user, and append it to the project detailTableView.
        messageSend()
    }
    
    var comments: [Comment]?
    
    func messageSend() {
        
        if let project = project,
            let projectID = project.identifier,
            let sender = UserController.currentUser,
            let text = messangerTextField.text {
            
            print("\n\nThe project is \(project)")
            print("The project ID is \(projectID)")
            print("The sender is \(sender)")
            print("The text is \(text)")
            
            ProjectController.fetchProjectForIdentifier(projectID, completion: { (project) in
                if project != nil {
                    CommentController.addComment(project!, sender: sender.displayName, text: text)
                } else {
                    print("No project was returned for the project ID of: \(projectID)")
                }
            })
        }
        messangerTextField.text = ""
        messangerTextField.resignFirstResponder()
        //scrollToBottom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        detailTableView.sectionHeaderHeight = 49
        
        if let project = project {
            CommentController.observeCommentsForProject(project, completion: { (comments) in
                self.comments = comments
                self.detailTableView.reloadData()
            })
        }
        
        // TESTING
        
        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 40
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: self.view.window)
        
    }
    
    // TODO: Create func/method that will observe messages that belong to the group. Similar to how we observe projects in the ProjectViewController
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = self.comments else {
            
            print("There are no comments 😱")
            return 0
        }
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        // Configure the cell...
        // TODO: Configure cell with comment
        
        guard let comment = comments?[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = comment.sender
        cell.detailTextLabel?.text = comment.text
        
        return cell
    }
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableCellWithIdentifier("headerView") as? CustomHeaderCell ?? CustomHeaderCell()
//        
//        headerView.fileName.text = self.project?.urlName
//        
//        return headerView.contentView
//    }
    
    // MARK: - Keyboard translation & scroll
    
    func keyboardWillShow(sender: NSNotification) {
        guard let userInfo: [NSObject: AnyObject] = sender.userInfo,
            keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size,
            offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size else { return }
        if keyboardSize.height == offset.height && self.view.frame.origin.y == 0 {
            UIView.animateWithDuration(0.1, animations: {
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animateWithDuration(0.1, animations: {
                self.view.frame.origin.y += (keyboardSize.height - offset.height)
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        guard let userInfo: [NSObject: AnyObject] = sender.userInfo,
            keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size else { return }
        self.view.frame.origin.y  += keyboardSize.height
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
}

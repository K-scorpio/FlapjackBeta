//
//  ProjectDetailViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 7/14/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import QuickLook
//import SwiftyDropbox

class ProjectDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    
//    var dbRestClient: DBRestClient!
    
//    var dropboxMetadata: DBMetadata!
    
    let quickLookController = QLPreviewController()
    
//    let fileNames = ["AppCoda-PDF.pdf", "AppCoda-Pages.pages", "AppCoda-Word.docx", "AppCoda-Keynote.key", "AppCoda-Text.txt", "AppCoda-Image.jpeg"]
    
    var project: Project?
    var comments: [Comment]?
    
//    let fileNames = project.urlString
    var fileURLs = [NSURL]()
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var messangerTextField: UITextField!
    
    @IBAction func messangerSendButtonTapped(sender: AnyObject) {
        // i want to take messangerTextField.text, set it as a comment using the current user, and append it to the project detailTableView.
        messageSend()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
//        navigationItem.title = ProjectViewController.projects[indexPath.row].name
//        prepareFileURLs()
        
        quickLookController.dataSource = self
        quickLookController.delegate = self
        
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
    
    func configureTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.registerNib(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        detailTableView.reloadData()
    }
    
//    func prepareFileURLs() {
//        for file in fileNames {
//            let fileParts = file.componentsSeparatedByString(".")
//            if let fileURL = NSBundle.mainBundle().URLForResource(fileParts[0], withExtension: fileParts[1]) {
//                if NSFileManager.defaultManager().fileExistsAtPath(fileURL.path!) {
//                    fileURLs.append(fileURL)
//                }
//            }
//        }
//    }
    
    func getFileTypeFromFileExtension(fileExtension: String) -> String {
        var fileType = ""
        
        switch fileExtension {
        case "docx":
            fileType = "Microsoft Word document"
            
        case "pages":
            fileType = "Pages document"
            
        case "jpeg":
            fileType = "Image document"
            
        case "key":
            fileType = "Keynote document"
            
        case "pdf":
            fileType = "PDF document"
            
            
        default:
            fileType = "Text document"
            
        }
        
        return fileType
    }
    
    func extractAndBreakFilenameInComponents(fileURL: NSURL) -> (fileName: String, fileExtension: String) {
        // Break the NSURL path into its components and create a new array with those components.
        let fileURLParts = fileURL.path!.componentsSeparatedByString("/")
        
        // Get the file name from the last position of the array above.
        let fileName = fileURLParts.last
        
        // Break the file name into its components based on the period symbol (".").
        let filenameParts = fileName?.componentsSeparatedByString(".")
        
        // Return a tuple.
        return (filenameParts![0], filenameParts![1])
    }
    
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        return fileURLs[index]
    }
    
    func previewControllerWillDismiss(controller: QLPreviewController) {
        print("The Preview Controller will be dismissed.")
    }
    
    func previewControllerDidDismiss(controller: QLPreviewController) {
        detailTableView.deselectRowAtIndexPath(detailTableView.indexPathForSelectedRow!, animated: true)
        print("The Preview Controller has been dismissed.")
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if QLPreviewController.canPreviewItem(fileURLs[indexPath.row]) {
            quickLookController.currentPreviewItemIndex = indexPath.row
            //            navigationController?.pushViewController(quickLookController, animated: true)
            presentViewController(quickLookController, animated: true, completion: nil)
        }
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

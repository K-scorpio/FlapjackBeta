//
//  NewProjectViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/21/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {

    @IBOutlet weak var projectNameTextField: UITextField!
    
    @IBOutlet weak var projectUrlTextField: UITextField!
    
    @IBOutlet weak var urlNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        newProject()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func newProject() {
        let project = Project(name: projectNameTextField.text ?? "", creator: UserController.currentUser?.displayName ?? "", urlString: projectUrlTextField.text ?? "", urlName: urlNameTextField.text ?? "")
        ProjectController.sharedInstance.addProject(project.name, creator: project.creator, urlString: project.urlString, urlName: project.urlName)
    }
}

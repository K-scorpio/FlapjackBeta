//
//  NewProjectViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/21/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewProjectViewController: UIViewController, UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    @IBOutlet weak var projectNameTextField: UITextField!
    
    @IBOutlet weak var projectUrlTextField: UITextField!
    
    @IBOutlet weak var urlNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- UIDocumentMenuDelegate

    @IBAction func importFileButtonTapped(sender: AnyObject) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String, kUTTypeAudio as String, kUTTypeGIF as String, kUTTypeRawImage as String, kUTTypeTIFF as String, kUTTypePDF as String, kUTTypeData as String], inMode: .Import)
        importMenu.delegate = self
        importMenu.addOptionWithTitle("Create New Document", image: nil, order: .First, handler: { print("New Doc Requested") })
        presentViewController(importMenu, animated: true, completion: nil)
        
        // NEED TO GET FILE PATHS STRING OR WHATEVER IT'S STORED AS, STORED IN THE "PROJECT"
        importMenu.title = urlNameTextField.text
        
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        newProject()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func newProject() {
        ProjectController.addProject(projectNameTextField.text ?? "", creator: UserController.currentUser?.displayName ?? "", urlString: projectUrlTextField.text ?? "", urlName: urlNameTextField.text ?? "")
    }
    
    
    func handleImportPickerPressed(sender: AnyObject) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as NSString as String], inMode: .Import)
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    // MARK:- UIDocumentMenuDelegate
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    // MARK:- UIDocumentPickerDelegate
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        // Do something
        print(url)
//        url.
    }
}

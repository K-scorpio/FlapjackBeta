//
//  LoginViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/20/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var userDisplayName: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var createNewAccount: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var pickImageButton: UIButton!
    
    
    enum Account {
        case existing
        case new
    }
    
    var account = Account.existing
    
    
    @IBAction func pickImageButtonTapped(sender: AnyObject) {
        let myImagePicker = UIImagePickerController()
        
        myImagePicker.delegate = self
        let alert = UIAlertController(title: "title", message: nil, preferredStyle: .ActionSheet)
        let myCameraAction =  UIAlertAction(title: "Take photo", style: .Default) { (_) in
            myImagePicker.sourceType = .Camera
            self.presentViewController(myImagePicker, animated: true, completion: nil)
        }
        let photoLibraryAction = UIAlertAction(title: "Choose from photo library", style: .Default) { (_) in
            myImagePicker.sourceType = .PhotoLibrary
            self.presentViewController(myImagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            alert.addAction(myCameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            alert.addAction(photoLibraryAction)
        }
        presentViewController(alert, animated: true, completion: nil)

        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        myImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        accountCheck()
    }
    
    @IBAction func createNewAccountButtonTapped(sender: AnyObject) {
        updateLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLoginView() {
        if account == .existing {
            account = .new
            userDisplayName.hidden = false
            myImageView.hidden = false
            createNewAccount.setTitle("Have existing account?", forState: .Normal)
            loginButton.setTitle("Create Account", forState: .Normal)
            pickImageButton.hidden = false
        } else {
            account = .existing
            userDisplayName.hidden = true
            myImageView.hidden = true
            createNewAccount.setTitle("Create New Account", forState: .Normal)
            loginButton.setTitle("Login", forState: .Normal)
            pickImageButton.hidden = true
            
        }
    }
    
    func accountCheck() {
        if account == .existing {
            if let email = userEmailTextField.text where email.characters.count > 0, let password = userPasswordTextField.text where password.characters.count > 0 {
                UserController.authUser(email, password: password, completion: { (user) in
                    if let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                })
            }
        } else {
            if account == .new {
                if let email = userEmailTextField.text where email.characters.count > 0, let password = userPasswordTextField.text where password.characters.count > 0, let image = myImageView.image, let displayName = userDisplayName.text where displayName.characters.count > 0 {
                    UserController.createUser(displayName, profileImage: image, email: email, password: password, completion: { (user) in
                        if let _ = user {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    })
                }
            }
        }
    }
    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}

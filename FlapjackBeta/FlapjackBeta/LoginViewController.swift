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
    
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var flapjackName: UIImageView!
    
    @IBOutlet weak var displayNameBackground: UIView!
    
    @IBOutlet weak var emailBackground: UIView!
    
    @IBOutlet weak var passwordBackground: UIView!
    
    enum Account {
        case existing
        case new
    }
    
    var account = Account.existing
    
    @IBAction func forgotPasswordButtonTapped(sender: AnyObject) {
    }
    
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
        view.backgroundColor = UIColor(patternImage: UIImage(named:"Login Background")!)
        
        userDisplayName.backgroundColor = UIColor.clearColor()
        userDisplayName.attributedPlaceholder = NSAttributedString(string:"display name",
                                                                      attributes:[NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        userDisplayName.borderStyle = UITextBorderStyle.None
        userDisplayName.font = UIFont.systemFontOfSize(20)
        userDisplayName.autocorrectionType = UITextAutocorrectionType.No
        userDisplayName.keyboardType = UIKeyboardType.Default
        userDisplayName.returnKeyType = UIReturnKeyType.Done
        
        userPasswordTextField.backgroundColor = UIColor.clearColor()
        userPasswordTextField.attributedPlaceholder = NSAttributedString(string:"password",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        userPasswordTextField.borderStyle = UITextBorderStyle.None
        userPasswordTextField.font = UIFont.systemFontOfSize(20)
        userPasswordTextField.autocorrectionType = UITextAutocorrectionType.No
        userPasswordTextField.keyboardType = UIKeyboardType.Default
        userPasswordTextField.returnKeyType = UIReturnKeyType.Done
        
        userEmailTextField.backgroundColor = UIColor.clearColor()
        userEmailTextField.attributedPlaceholder = NSAttributedString(string:"email",
                                                                         attributes:[NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        userEmailTextField.borderStyle = UITextBorderStyle.None
        userEmailTextField.font = UIFont.systemFontOfSize(20)
        userEmailTextField.autocorrectionType = UITextAutocorrectionType.No
        userEmailTextField.keyboardType = UIKeyboardType.Default
        userEmailTextField.returnKeyType = UIReturnKeyType.Done
        
        displayNameBackground.layer.cornerRadius = 12.0
        emailBackground.layer.cornerRadius = 12.0
        passwordBackground.layer.cornerRadius = 12.0

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
            flapjackName.hidden = true
            myImageView.image = UIImage(named: "profile")
            createNewAccount.setTitle("Have existing account?", forState: .Normal)
            loginButton.setTitle("Create Account", forState: .Normal)
            pickImageButton.hidden = false
            forgotButton.hidden = true
        } else {
            account = .existing
            userDisplayName.hidden = true
            myImageView.hidden = true
//            flapjackName.hidden = false
            flapjackName.image = UIImage(named: "Flapjack Name")
            createNewAccount.setTitle("Create New Account", forState: .Normal)
            loginButton.setTitle("Sign in", forState: .Normal)
            pickImageButton.hidden = true
            forgotButton.hidden = false
            
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

//
//  ViewController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! CustomHeaderCell
    headerCell.backgroundColor = UIColor.grayColor()
    
    switch (section) {
    case 0:
    headerCell.fileName.text = "Project Name";
    default:
    headerCell.fileName.text = "";
    }
    
    return headerCell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func openGoogleButtonTapped(sender: AnyObject) {
        guard let url = NSURL(string: "http://www.google.com") else {
            return
        }
        let safariViewController = SFSafariViewController(URL: url)
        presentViewController(safariViewController, animated: true, completion: nil)
        
    }

}

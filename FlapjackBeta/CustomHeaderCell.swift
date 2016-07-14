//
//  CustomHeaderCell.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import SafariServices

class CustomHeaderCell: UITableViewCell, UINavigationControllerDelegate {
    
    var project: Project?

    @IBOutlet weak var fileName: UILabel!
    
    @IBAction func openGoogleButtonTapped(sender: AnyObject) {
//        guard let url = NSURL(string: "http://www.google.com") else {
//            return
//        }
//        let safariViewController = SFSafariViewController(URL: url)
//        presentViewController(safariViewController, animated: true, completion: nil
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

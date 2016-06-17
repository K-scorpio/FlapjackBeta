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

    @IBOutlet weak var fileName: UILabel!
    
    @IBAction func openGoogleButtonTapped(sender: AnyObject) {
        // 
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

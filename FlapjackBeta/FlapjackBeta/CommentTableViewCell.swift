//
//  CommentTableViewCell.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var displayNameTextField: UILabel!
    
    @IBOutlet weak var commentTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addCommentToURL(text: String, project: Project, completion: ((success: Bool) -> Void)?) {
//        let comment = Comment(text: commentTextField.text ?? "", sender: UserController.currentUser!.displayName ?? "", project: )
    }
}

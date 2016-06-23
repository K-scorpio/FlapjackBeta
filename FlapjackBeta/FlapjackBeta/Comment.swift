//
//  Comment.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation
import UIKit

class Comment: Equatable, FirebaseType {
    
    private let kText = "text"
    private let kSender = "sender"
    
    var text: String
    var sender: String
 
    var identifier: String?
    
    var endpoint: String {
        return "comments"
    }
    
    init(text: String, sender: String, project: Project) {
        self.text = text
        self.sender = sender
    }
    
    var jsonValue: [String: AnyObject] {
        return [kText: text, kSender: sender]
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String) {
        guard let text = dictionary[kText] as? String,
            sender = dictionary[kSender] as? String else {
                return nil
        }
        self.text = text
        self.sender = sender
        self.identifier = identifier
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.text == rhs.text && lhs.sender == rhs.sender
}
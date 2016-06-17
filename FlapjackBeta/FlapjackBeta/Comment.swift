//
//  Comment.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation
import UIKit

class Comment: Equatable {
    
    private let kText = "text"
    private let kSender = "sender"
    private let kProject = "project"
    
    var text: String
    var sender: String
    var project: Project
    
    var endpoint: String {
        return "comments"
    }
    
    init(text: String, sender: String, project: Project) {
        self.text = text
        self.sender = sender
        self.project = project
    }

    var jsonValue: [String: AnyObject] {
        return [kText: text, kSender: sender, kProject: project]
    }
    
    required init?(dictionary: [String: AnyObject], sender: String, project: Project) {
        guard let text = dictionary[kText] as? String,
            sender = dictionary[kSender] as? String,
            project = dictionary[kProject] as? Project else {
                return nil
        }
        self.text = text
        self.sender = sender
        self.project = project
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.text == rhs.text && lhs.sender == rhs.sender && lhs.project == rhs.project
}
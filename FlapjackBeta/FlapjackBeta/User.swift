//
//  User.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation
import UIKit

class User: Equatable {
    
    private let kDisplayName = "displayName"
    private let kProfileImage = "profileImage"
    private let kProjects = "projects"

    var displayName: String
    var profileImage: UIImage
    var identifier: String?
    var projects: [String]
    
    var endpoint: String {
        return "users"
    }
    
    init(displayName: String, profileImage: UIImage) {
        self.displayName = displayName
        self.profileImage = profileImage
        self.projects = []
    }

    var jsonValue: [String: AnyObject] {
        return [kDisplayName: displayName, kProfileImage: profileImage]
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String) {
        guard let displayName = dictionary[kDisplayName] as? String,
            profileImage = dictionary[kProfileImage] as? UIImage,
            projects = dictionary[kProjects] as? [String] else {
                return nil
        }
        self.displayName = displayName
        self.profileImage = profileImage
        self.identifier = identifier
        self.projects = projects
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.displayName == rhs.displayName && lhs.profileImage == rhs.profileImage && lhs.projects == rhs.projects
}
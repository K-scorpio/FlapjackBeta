//
//  User.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

class User: Equatable, FirebaseType {
    
    private let kDisplayName = "displayName"
    private let kProfileImage = "profileImage"
    private let kProjectIds = "projectIds"
    
    var displayName: String
    var profileImage: UIImage
    var identifier: String?
    var projectIds: [String]
    
    var endpoint: String {
        return "users"
    }
    
    init(displayName: String, profileImage: UIImage? = nil, identifier: String) {
        self.displayName = displayName
        self.profileImage = profileImage ?? UIImage(named: "profile") ?? UIImage()
        self.projectIds = []
        self.identifier = identifier
    }
    
    var jsonValue: [String: AnyObject] {
        return [kDisplayName: displayName, kProfileImage: profileImage.base64String ?? "", kProjectIds: projectIds.map { [$0: true] }]
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String) {
        guard let displayName = dictionary[kDisplayName] as? String else {
            return nil
        }
        self.displayName = displayName
        if let profileImage = dictionary[kProfileImage] as? String {
            self.profileImage = UIImage(base64: profileImage) ?? UIImage(named: "profile") ?? UIImage()
        } else {
            self.profileImage = UIImage(named: "profile") ?? UIImage()
        }
        
        self.identifier = identifier
        if let projects = dictionary[kProjectIds] as? [String] {
            self.projectIds = projects
        } else {
            self.projectIds = []
        }
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.displayName == rhs.displayName && lhs.profileImage == rhs.profileImage && lhs.projectIds == rhs.projectIds
}
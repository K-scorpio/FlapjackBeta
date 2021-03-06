//
//  Project.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class Project: Equatable, FirebaseType {
    
    private let kName = "name"
    private let kCreator = "creator"
    private let kURLString = "urlString"
    private let kURLName = "urlName"
    private let kComments = "comments"
    
    let name: String
    var identifier: String?
    let creator: String
    let urlString: String
    let urlName: String
    var commentIds: [String]
    
    var endpoint: String {
        return "projects"
    }
    
    init(name: String, creator: String, urlString: String, urlName: String) {
        self.name = name
        self.creator = creator
        self.urlString = urlString
        self.urlName = urlName
        self.commentIds = []
    }
    
    var jsonValue: [String: AnyObject] {
        var commentDict: [String: AnyObject] = [:]
        for commentId in commentIds {
            commentDict.updateValue(true, forKey: commentId)
        }
        return [kName: name, kCreator: creator, kURLString: urlString, kURLName: urlName, kComments: commentDict]
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String) {
        guard let name = dictionary[kName] as? String,
            creator = dictionary[kCreator] as? String,
            urlString = dictionary[kURLString] as? String,
            urlName = dictionary[kURLName] as? String else {
                return nil
        }
        self.name = name
        self.creator = creator
        self.identifier = identifier
        self.urlString = urlString
        self.urlName = urlName
        if let commentIds = dictionary[kComments] as? [String: AnyObject] {
            self.commentIds = Array(commentIds.keys)
        } else {
            self.commentIds = []
        }
    }
}

func ==(lhs: Project, rhs: Project) -> Bool {
    return lhs.name == rhs.name && lhs.creator == rhs.creator
}
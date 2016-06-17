//
//  Project.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/17/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class Project: Equatable {
    
    private let kName = "name"
    private let kCreator = "creator"
    
    let name: String
    var identifier: String?
    let creator: String
    
    var endpoint: String {
        return "projects"
    }
    
    init(name: String, creator: String) {
        self.name = name
        self.creator = creator
    }
    
    var jsonValue: [String: AnyObject] {
        return [kName: name, kCreator: creator]
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String) {
        guard let name = dictionary[kName] as? String,
            creator = dictionary[kCreator] as? String else {
                return nil
        }
        self.name = name
        self.creator = creator
        self.identifier = identifier
    }
}

func ==(lhs: Project, rhs: Project) -> Bool {
    return lhs.name == rhs.name && lhs.creator == rhs.creator
}
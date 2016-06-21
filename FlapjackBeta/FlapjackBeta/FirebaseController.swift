//
//  FirebaseController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/20/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    static let ref = FIRDatabase.database().reference()
}

protocol FirebaseType {
    var identifier: String? { get set }
    var endpoint: String { get }
    var jsonValue: [String: AnyObject] { get }
    
    init?(dictionary: [String: AnyObject], identifier: String)
    
    mutating func save()
    func delete()
}

extension FirebaseType {
    
    mutating func save() {
        var newBase = FirebaseController.ref.child(self.endpoint)
        if let identifier = identifier {
            newBase = newBase.child(identifier)
        } else {
            newBase = newBase.childByAutoId()
            self.identifier = newBase.key
        }
        newBase.updateChildValues(self.jsonValue)
    }
    
    func delete() {
        guard let identifier = self.identifier else {
            return
        }
        FirebaseController.ref.child(self.endpoint).child(identifier)
    }
}
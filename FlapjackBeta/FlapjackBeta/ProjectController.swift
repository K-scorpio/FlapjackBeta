//
//  ProjectController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/20/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import Firebase
import SwiftyDropbox

class ProjectController {

//    static let sharedInstance = ProjectController()
//    
//    var projects: [Project]
//    
//    init() {
//        self.projects = []
//        self.observeProjects { (projects) in
//            self.projects = projects
//        }
//    }
    
    static func addProject(name: String, creator: String, urlString: String, urlName: String) {
        var project = Project(name: name, creator: creator, urlString: urlString, urlName: urlName)
        // Saves to Firebase projects endpoint
        project.save()
        // Saves project to users endpoint in Firebase
        if var user = UserController.currentUser, let identifier = project.identifier {
            user.projectIds.append(identifier)
            user.save()
        }
    }
    
    static func removeProject(project: Project) { // from Users ProjectID's and from Projects endpoint
        //Firebse Delete
        project.delete()
        // Deletes project from users projectIDs
        if var currentUser = UserController.currentUser, let projectID = project.identifier, let index = currentUser.projectIds.indexOf(projectID) {
            currentUser.projectIds.removeAtIndex(index)
            currentUser.save()
        }
    }
    
    static func fetchProjectForIdentifier(identifier: String, completion: (project: Project?) -> Void) {
        FirebaseController.ref.child("projects").child(identifier).observeSingleEventOfType(.Value, withBlock: { data in
            guard let dataDict = data.value as? [String: AnyObject],
                project = Project(dictionary: dataDict, identifier: data.key) else {
                    completion(project: nil)
                    return
            }
            completion(project: project)
        })
    }
    
    static func observeProjects(completion: (projects: [Project]) -> Void) {
        FirebaseController.ref.child("projects").observeEventType(.Value, withBlock: { (jsonSnapshot) in
            guard let dataDictionary = jsonSnapshot.value as? [String: [String: AnyObject]] else {
                completion(projects: [])
                return
            }
            let projects = dataDictionary.flatMap({Project(dictionary: $1, identifier: $0)})
            completion(projects: projects)
        })
    }
}







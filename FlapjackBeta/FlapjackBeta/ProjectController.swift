//
//  ProjectController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/20/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import Firebase

class ProjectController {

    static let sharedInstance = ProjectController()
    
    var projects: [Project]
    
    init() {
        self.projects = []
        self.observeProjects { (projects) in
            self.projects = projects
        }
    }
    
    func addProject(name: String, creator: String, urlString: String, urlName: String) {
        var project = Project(name: name, creator: creator, urlString: urlString, urlName: urlName)
        // Saves to Firebase projects endpoint
        project.save()
        // Saves project to users endpoint in Firebase
        if var user = UserController.currentUser, let identifier = project.identifier {
            user.projectIds.append(identifier)
            user.save()
        }
    }
    
    func removeProject(project: Project) { // from Users ProjectID's and from Projects endpoint
        if let index = projects.indexOf(project) {
            projects.removeAtIndex(index)
        }
        //Firebse Delete
        project.delete()
    }
    
    func fetchProjects() {
        
    }
    
    func observeProjects(completion: (projects: [Project]) -> Void) {
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







//
//  CommentController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/22/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation
import Firebase

class CommentController {
    
    static func addComment(project: Project, sender: String, text: String) {
        var comment = Comment(text: text, sender: sender, project: project)
        // Saves to Firebase comments endpoint
        comment.save()
        // Saves comment to project endpoint in Firebase
        var savedProject = project
        if let commentID = comment.identifier {
            project.commentIds.append(commentID)
            savedProject.save()
        }
    }
    
    static func removeProject(project: Project) { // from Users ProjectID's and from Projects endpoint
        //Firebse Delete
        project.delete()
        // TODO: Setup - Deletes comment from projects commentIDs
    }
    
    static func fetchCommentForIdentifier(identifier: String, completion: (comment: Comment?) -> Void) {
        FirebaseController.ref.child("comments").child(identifier).observeSingleEventOfType(.Value, withBlock: { data in
            guard let dataDict = data.value as? [String: AnyObject],
                comment = Comment(dictionary: dataDict, identifier: data.key) else {
                    completion(comment: nil)
                    return
            }
            completion(comment: comment)
        })
    }
    
    // TODO: Fix this so it is fetching the comments for projectID AND DON'T COPY AND PASTE CODE!!!!!!!!!!!
    
    static func observeCommentsForProject(project: Project, completion: (comments: [Comment]?) -> Void) {
        // Fetch the proje0cts commentIDs
        if let projectId = project.identifier {
            FirebaseController.ref.child("projects").child(projectId).child("comments").observeEventType(.Value, withBlock: { (jsonSnapshot) in
                guard let commentDict = jsonSnapshot.value as? [String: AnyObject] else {
                    completion(comments: [])
                    return
                }
                let commentKeys = Array(commentDict.keys)
                var comments = [Comment]()
                let group = dispatch_group_create()
                for commentId in commentKeys {
                    dispatch_group_enter(group)
                    fetchCommentForIdentifier(commentId, completion: { (comment) in
                        if let comment = comment {
                            comments.append(comment)
                        }
                        dispatch_group_leave(group)
                    })
                }
                dispatch_group_notify(group, dispatch_get_main_queue(), {
                    let sortedComments = comments.sort {$0.identifier < $1.identifier}
                    completion(comments: sortedComments)
                })
            })
        }
    }
}

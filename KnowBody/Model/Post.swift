//
//  Post.swift
//  KnowBody
//
//  Created by James Swinehart on 8/19/25.
//

import Firebase
import FirebaseFirestore

struct Post: Identifiable, Codable {
    @DocumentID var postId: String?
    var ownerUid: String
    var timestamp: Timestamp
    var bookmarks: Int
    var postTitle: String         // postTitle
    var description: String                     // description
    var age: Int?                 // age (optional)
    var sex: String                 // sex (enum below) or use String
    var hasMedicalHistory: Bool          // hasMedicalHistory toggle
    var selectedSpecialties: Set<String>   // from selectedSpecialties (sorted array)
    
    var id: String {
        return postId ?? NSUUID().uuidString
    }
    
    var user: User?
}




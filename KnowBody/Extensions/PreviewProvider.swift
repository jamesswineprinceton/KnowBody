//
//  PreviewProvider.swift
//  KnowBody
//
//  Created by James Swinehart on 8/17/25.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(
        id: NSUUID().uuidString,
        email: "grant@gmail.com",
        firstname: "Grant",
        lastname: "Scarborough",
        location: "Columbus, GA",
        title: "MD",
        npi: "123456789",
        selectedSpecialties: Set(["Primary Care"])
    )
    
    let post = Post(ownerUid: "123", timestamp: Timestamp(), bookmarks: 0, postTitle: "Test Title", description: "Test Description", age: 43, sex: "Male", hasMedicalHistory: false, selectedSpecialties: [])
}

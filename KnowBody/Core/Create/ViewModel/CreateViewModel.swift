//
//  CreateViewModel.swift
//  KnowBody
//
//  Created by James Swinehart on 8/19/25.
//

import Firebase
import FirebaseAuth

class CreateViewModel: ObservableObject {
    @Published var postTitle = ""
    @Published var age: Int = 0
    @Published var sex: String = ""
    @Published var hasMedicalHistory = false
    @Published var description = ""
    @Published var selectedSpecialties: Set<String> = []
    
    func uploadPost() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let post = Post(ownerUid: uid, timestamp: Timestamp(), bookmarks: 0, postTitle: postTitle, description: description, age: age, sex: sex, hasMedicalHistory: hasMedicalHistory, selectedSpecialties: selectedSpecialties)
        try await PostService.uploadPost(post)
    }
}

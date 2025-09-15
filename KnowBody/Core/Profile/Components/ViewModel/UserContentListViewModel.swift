//
//  UserContentListViewModel.swift
//  KnowBody
//
//  Created by James Swinehart on 8/20/25.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        var posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        
        self.posts = posts
    }
}

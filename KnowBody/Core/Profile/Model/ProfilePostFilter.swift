//
//  ProfilePostFilter.swift
//  KnowBody
//
//  Created by James Swinehart on 7/31/25.
//

import Foundation

enum ProfilePostFilter: Int, CaseIterable, Identifiable {
    case posts
    case replies
    
    var title: String {
        switch self {
        case .posts: return "Posts"
        case .replies: return "Replies"
        }
    }
    
    var id: Int { return self.rawValue }
}

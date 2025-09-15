//
//  User.swift
//  KnowBody
//
//  Created by James Swinehart on 8/16/25.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let email: String
    let firstname: String
    let lastname: String
    let location: String
    let title: String
    let npi: String
    let selectedSpecialties: Set<String> 
    var profileImageUrl: String?
    var bio: String?
    var link: String?
}

//
//  ProfileHeaderView.swift
//  KnowBody
//
//  Created by James Swinehart on 8/18/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        // Profile picture
        HStack(alignment: .top) {
            
            // Bio and Stats
            VStack(alignment: .leading, spacing: 12) {
                
                // Full name, specialty, and location
                VStack(alignment: .leading, spacing: 4) {
                    
                    let first = user?.firstname ?? ""
                    let last = user?.lastname ?? ""
                    let title = user?.title ?? ""

                    let name = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
                    let headerLine = [name, title].filter { !$0.isEmpty }.joined(separator: ", ")

                    Text(headerLine)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    let specialties = user?.selectedSpecialties.joined(separator: ", ") ?? ""
                    let location = user?.location ?? ""
                    
                    Text("\(specialties), \(location)")
                        .font(.subheadline)
                }
                
                if (user?.bio) != nil {
                    Text(user?.bio ?? "")
                        .font(.footnote)
                }
                
                Text("2 followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            CircularProfileImageView(user: user, size: .medium)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user)
    }
}

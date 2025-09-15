//
//  ProfileView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/30/25.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            // Follow Button
            VStack(spacing: 20) {
    
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                // User Content
                UserContentListView(user: user)

            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .padding(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}

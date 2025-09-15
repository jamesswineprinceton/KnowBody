//
//  CurrentUserProfileView.swift
//  KnowBody
//
//  Created by James Swinehart on 8/17/25.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                // Follow Button
                VStack(spacing: 20) {
                    
                    
                    ProfileHeaderView(user: currentUser)
                    
                    
                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
                .sheet(isPresented: $showEditProfile, content: {
                    if let user = currentUser {
                        EditProfileView(user: user)
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}

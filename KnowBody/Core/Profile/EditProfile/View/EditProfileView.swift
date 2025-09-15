//
//  EditProfileView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/31/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    
    @State private var selectedSpecialties: Set<String> = []
    @State private var showSpecialtySheet: Bool = false
    @State private var location = ""
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    
    let specialties = Specialties.all
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.white)
                    .ignoresSafeArea(edges: [.bottom, .horizontal])
                
                VStack {
                    
                    // Name and Profile Image
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            let first = user.firstname
                            let last = user.lastname
                            let title = user.title

                            let name = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
                            let headerLine = [name, title].filter { !$0.isEmpty }.joined(separator: ", ")

                            Text(headerLine)
                        }
                        .font(.footnote)
                        
                        Spacer()
                        
                        PhotosPicker(selection: Binding(get: { viewModel.selectedItem }, set: { viewModel.selectedItem = $0 })) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Specialties
                    VStack(alignment: .leading) {
                        Text("Specialties")
                            .fontWeight(.semibold)
                        
                        Button {
                            showSpecialtySheet = true
                        } label: {
                            HStack {
                                Text(selectedSpecialties.isEmpty ? "Select your specialties" : Array(selectedSpecialties).sorted().joined(separator: ", "))
                                    .foregroundColor(selectedSpecialties.isEmpty ? .blue : .black)
                                    .font(.footnote)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                            }
                        }
                        .specialtyMenu(
                            isPresented: $showSpecialtySheet,
                            selectedItems: $selectedSpecialties,
                            allItems: specialties,
                            title: "Specialties"
                        )
                    }
                    
                    Divider()
                    
                    // Location
                    VStack(alignment: .leading) {
                        Text("Location")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your city, state...", text: $location, axis: .vertical)
                    }
                    
                    Divider()
                    
                    // Bio
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your bio", text: $bio, axis: .vertical)
                    }
                    
                    Divider()
                    
                    // Link
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your link", text: $link, axis: .vertical)
                    }
                    
                    Divider()
                    
                    // Toggle Private Profile
                    
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                    
                    Spacer()
                }
                .font(.footnote)
                .padding()
                
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem( placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)

                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: dev.user)
    }
}

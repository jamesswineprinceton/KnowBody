//
//  RegistrationView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/30/25.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @State private var showSpecialtySheet: Bool = false
    @State private var selectedImage: UIImage?
    @State private var showCameraPicker: Bool = false
    @State private var showPhotoLibraryPicker: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let specialties = Specialties.all
    
    var body: some View {
        VStack {
                Spacer()
                
                Text("KnowBody")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }
                
                    VStack {
                        TextField("Enter your first name", text: $viewModel.firstname)
                            .modifier(TextFieldModifier())
                    
                        TextField("Enter your last name", text: $viewModel.lastname)
                            .modifier(TextFieldModifier())

                        TextField("Enter your city and state", text: $viewModel.location)
                        .modifier(TextFieldModifier())
                }
                    .padding(.top)
                    
                VStack {
                    Menu {
                        Picker("Select your title", selection: $viewModel.title) {
                            Text("MD").tag("MD")
                            Text("DO").tag("DO")
                            Text("NP").tag("NP")
                            Text("PA").tag("PA")
                            Text("RN").tag("RN")
                            Text("PharmD").tag("PharmD")
                            Text("DDS").tag("DDS")
                        }
                    } label: {
                        HStack {
                            Text(viewModel.title.isEmpty ? "Select your title" : viewModel.title)
                                .foregroundColor(viewModel.title.isEmpty ? .blue : .black)
                                .font(.subheadline)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    }
                    .font(.subheadline)
                    
                    Button {
                        showSpecialtySheet = true
                    } label: {
                        HStack {
                            Text(viewModel.selectedSpecialties.isEmpty ? "Select your specialties" : viewModel.selectedSpecialties.joined(separator: ", "))
                                .foregroundColor(viewModel.selectedSpecialties.isEmpty ? .blue : .black)
                                .font(.subheadline )
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    }
                    .specialtyMenu(
                        isPresented: $showSpecialtySheet,
                        selectedItems: $viewModel.selectedSpecialties,
                        allItems: specialties,
                        title: "Specialties"
                    )
                    
                    
                    TextField("Enter your NPI", text: $viewModel.npi)
                        .modifier(TextFieldModifier())

                    Menu {
                        Button {
                            showPhotoLibraryPicker = true
                        } label: {
                            Label("Choose from Library", systemImage: "photo")
                                .foregroundColor(.gray)
                        }

                        Button {
                            showCameraPicker = true
                        } label: {
                            Label("Take a Photo", systemImage: "camera")
                                .foregroundColor(.gray)
                        }
                    } label: {
                        HStack {
                            Text(selectedImage == nil ? "Upload selfie with ID" : "Image uploaded")
                                .foregroundColor(selectedImage == nil ? .blue : .black)
                                .font(.subheadline)
                            Spacer()
                            Image(systemName: "camera")
                                .foregroundColor(.blue)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    }
                    .labelStyle(.titleAndIcon)
                    .sheet(isPresented: $showCameraPicker) {
                        ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
                    }
                    .sheet(isPresented: $showPhotoLibraryPicker) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                    }
                }
                .padding(.top)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Sign Up")
                        .modifier(BlueButtonModifier())
                }
                .padding(.top)
                
                Spacer()
                
                Divider()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

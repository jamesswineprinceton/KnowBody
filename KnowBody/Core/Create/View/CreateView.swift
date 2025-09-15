//
//  CreateView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/30/25.
//

import SwiftUI

struct CreateView: View {
    @Binding var selectedTab: Int
    @StateObject var viewModel = CreateViewModel()
    @FocusState private var isDescriptionFocused: Bool
    @State private var showSpecialtySheet: Bool = false
    
    let specialties = Specialties.all
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    // Computed property to check if any required fields are empty/invalid
    var isPostButtonDisabled: Bool {
        viewModel.postTitle.isEmpty ||
        viewModel.description.isEmpty ||
        viewModel.sex.isEmpty ||
        viewModel.selectedSpecialties.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 12) {
                        CircularProfileImageView(user: user, size: .small)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            HStack {
                                let first = user?.firstname ?? ""
                                let last = user?.lastname ?? ""
                                let title = user?.title ?? ""

                                let name = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
                                let headerLine = [name, title].filter { !$0.isEmpty }.joined(separator: ", ")

                                Text(headerLine)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            
                            let specialties = user?.selectedSpecialties.joined(separator: ", ") ?? ""
                            let location = user?.location ?? ""
                            
                            Text("\(specialties), \(location)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // Title
                        Text("Title")
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .padding(.vertical, 4)
                        
                        TextField("Your case in a few words...", text: $viewModel.postTitle, axis: .vertical)
                                .font(.headline)
                                .padding(.vertical, 4)
                        
                        Divider()
                        
                        // Description (multi-line)
                        
                        Text("Description")
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .padding(.vertical, 4)
                        
                        PlaceholderTextView(text: $viewModel.description,
                                            placeholder: "Symptoms, vitals, questions for specialists...",
                                            isFocused: $isDescriptionFocused)
                            .frame(height: 90)
                            .padding(.vertical, 4)
                        
                        Divider()
                        
                        // Age (footnote text – numeric only)
                        Text("Age")
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .padding(.vertical, 4)
                        
                        TextField("Enter patient's age", value: $viewModel.age, format: .number)
                            .keyboardType(.numberPad)
                            .font(.footnote)
                        .padding(.vertical, 4)
                        
                        Divider()
                        
                        // Sex dropdown (footnote text)
                        Menu {
                            Picker("Sex", selection: $viewModel.sex) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                                Text("Prefer not to say").tag("Prefer not to say")
                            }
                        } label: {
                            HStack {
                                Text(viewModel.sex.isEmpty ? "Sex" : viewModel.sex)
                                    .foregroundColor(viewModel.sex.isEmpty ? .blue : .primary)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                                    .imageScale(.small)
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Divider()
                        
                        // "Looking for..." specialty selection (footnote text)
                        Button {
                            showSpecialtySheet = true
                        } label: {
                            HStack {
                                Text(viewModel.selectedSpecialties.isEmpty
                                     ? "What specialties are you looking for?"
                                     : "Looking for:  \(viewModel.selectedSpecialties.sorted().joined(separator: ", "))")
                                .foregroundColor(viewModel.selectedSpecialties.isEmpty ? .blue : .primary)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                                    .imageScale(.small)
                            }
                        }
                        .specialtyMenu(
                            isPresented: $showSpecialtySheet,
                            selectedItems: $viewModel.selectedSpecialties,
                            allItems: specialties,
                            title: "Specialties"
                        )
                        .padding(.vertical, 8)
                        
                        Divider()
                        
                        // Medical history toggle (footnote text)
                        VStack(alignment: .leading) {
                            Toggle("Relevant Medical History", isOn: $viewModel.hasMedicalHistory)
                                .font(.footnote)
                            Text("Chronic condition, family history, etc.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                        
                        Divider ()
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("New Post")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            do {
                                try await viewModel.uploadPost()
                                await MainActor.run { selectedTab = 0 }
                            } catch {
                                // TODO: handle error (alert/toast)
                            }
                        }
                    }
                    .opacity(isPostButtonDisabled ? 0.5 : 1.0)
                    .disabled(isPostButtonDisabled)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(selectedTab: .constant(1))
    }
}

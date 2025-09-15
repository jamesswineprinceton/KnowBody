//
//  RegistrationViewModel.swift
//  KnowBody
//
//  Created by James Swinehart on 8/13/25.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var location: String = ""
    @Published var title: String = ""
    @Published var npi: String = ""
    @Published var selectedSpecialties: Set<String> = []
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            firstname: firstname,
            lastname: lastname,
            location: location,
            title: title,
            npi: npi,
            selectedSpecialties: selectedSpecialties
        )
    }
}

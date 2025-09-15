//
//  AuthService.swift
//  KnowBody
//
//  Created by James Swinehart on 8/13/25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
            print("DEBUG: Signed in user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, firstname: String, lastname: String, location: String, title: String, npi: String, selectedSpecialties: Set<String>) async throws {
        do { 
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, firstname: firstname, lastname: lastname, location: location, title: title, npi: npi, selectedSpecialties: selectedSpecialties, id: result.user.uid)
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
    
    @MainActor
    private func uploadUserData(withEmail email: String,
                                firstname: String,
                                lastname: String,
                                location: String,
                                title: String,
                                npi: String,
                                selectedSpecialties: Set<String>,
                                id: String
    ) async throws {
        let user = User(id: id,
                        email: email,
                        firstname: firstname,
                        lastname: lastname,
                        location: location,
                        title: title,
                        npi: npi,
                        selectedSpecialties: selectedSpecialties)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}

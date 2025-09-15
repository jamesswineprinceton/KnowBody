//
//  LoginViewModel.swift
//  KnowBody
//
//  Created by James Swinehart on 8/16/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password,)
    }
}

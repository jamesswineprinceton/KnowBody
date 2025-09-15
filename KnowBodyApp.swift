import SwiftUI
import Firebase

@main
struct KnowBodyApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoading {
                // Show loading screen while checking auth state
                VStack {
                    ProgressView()
                    Text("Loading...")
                        .padding(.top)
                }
            } else if authViewModel.isAuthenticated {
                CaseFeedView()
            } else {
                AuthenticationView()
            }
        }
    }
}

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = true
    
    init() {
        // Check current authentication state immediately
        isAuthenticated = Auth.auth().currentUser != nil
        print("Initial auth state: \(isAuthenticated)")
        
        // Set loading to false after a brief delay to ensure UI updates
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isLoading = false
        }
        
        // Listen for authentication state changes
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
                self?.isLoading = false
                print("Auth state changed: \(user != nil)")
            }
        }
    }
} 
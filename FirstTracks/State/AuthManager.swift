//
// AuthManager.swift
// bespoke
//
// Created by Jared Webber on 2023-12-27
//

// https://medium.com/@marwa.diab/firebase-authentication-in-swiftui-part-1-71a409108d9f

import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift

enum AuthState {
    case signedIn
    case signedOut
}

class AuthManager: ObservableObject {
    // TODO: - swap for custom User
    // https://firebase.google.com/docs/reference/js/v8/firebase.User
    @Published var user: FirebaseAuth.User?
    @Published var authState = AuthState.signedOut

    private var authStateHandle: AuthStateDidChangeListenerHandle!

    init() {
        configureAuthStateChanges()
    }

    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            print("Auth changed: \(user != nil)")
            Task {
                await self.updateState(user: user)
            }
        }
    }

    func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }

    func updateState(user: FirebaseAuth.User?) async {
        await MainActor.run {
            self.user = user
            let isAuthenticatedUser = user != nil

            self.authState = isAuthenticatedUser ? .signedIn : .signedOut
        }
    }

    func signOut() async throws {
        if Auth.auth().currentUser != nil {
            do {
                firebaseProviderSignOut(user!)
                try Auth.auth().signOut()
            } catch let error as NSError {
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
                throw error
            }
        }
    }

    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
        if Auth.auth().currentUser != nil {
            return try await authLink(credentials: credentials)
        } else {
            return try await authSignIn(credentials: credentials)
        }
    }

    private func authSignIn(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(with: credentials)
            
            print(result.user.uid)

            await updateState(user: result.user)
            return result
        } catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }
    }

    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            guard let user = Auth.auth().currentUser else { return nil }
            let result = try await user.link(with: credentials)
            await updateState(user: result.user)
            return result
        } catch {
            print("FirebaseAuthError: link(with:) failed, \(error)")
            throw error
        }
    }

    func googleAuth(_ user: GIDGoogleUser) async throws -> AuthDataResult? {
        guard let idToken = user.idToken?.tokenString else { return nil }

        let credentials = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        do {
            return try await authenticateUser(credentials: credentials)
        } catch {
            print("FirebaseAuthError: googleAuth(user:) failed. \(error)")
            throw error
        }
    }

    func firebaseProviderSignOut(_ user: FirebaseAuth.User) {
        let providers = user.providerData
            .map { $0.providerID }.joined(separator: ", ")

        if providers.contains("google.com") {
            GoogleSignInManager.shared.signOutFromGoogle()
        }
//        if user.currentProvider.contains("google.com") {
//            GoogleSignInManager.shared.signOutFromGoogle()
//        }
    }
}

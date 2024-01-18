//
// CreateOrLoginView.swift
// bespoke
//
// Created by Jared Webber on 2023-09-25
//

import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignInSwift
import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                Image("loginScreen")
                    .foregroundStyle(Color("blue"))
                    .padding()
                Spacer()

                SignInWithAppleButton(
                    onRequest: { _ in
                        print("Sign In With Apple")
                        // TODO: Request Apple Authorization
                    },
                    onCompletion: { _ in
                        // TODO: Handle AppleID Completion
                    }
                )
                .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
                .frame(width: 280, height: 45, alignment: .center)

                GoogleSignInButton {
                    signInWithGoogle()
                    print("Sign In With Google")
                }
                .frame(width: 280, height: 45, alignment: .center)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("yellow"))
        }
    }

    func signInWithGoogle() {
        GoogleSignInManager.shared.signInWithGoogle { user, error in
            if let error = error {
                print("GoogleSignInError: failed to sign in with Google, \(error))")
                return
            }

            guard let user = user else { return }
            Task {
                do {
                    let result = try await authManager.googleAuth(user)

                    if let result = result {
                        print("GoogleSignInSuccess: \(result.user.uid)")
                        dismiss()
                    }
                }
                catch {
                    print("GoogleSignInError: failed to authenticate with Google, \(error))")
                }
            }
        }
    }
}

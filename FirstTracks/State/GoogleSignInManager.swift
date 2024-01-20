//
// GoogleSignInManager.swift
// bespoke
//
// Created by Jared Webber on 2023-12-28
//

import Foundation
import GoogleSignIn

class GoogleSignInManager {
    static let shared = GoogleSignInManager()

    typealias GoogleAuthResult = (GIDGoogleUser?, Error?) -> Void

    private init() {}

    func signInWithGoogle(_ completion: @escaping GoogleAuthResult) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                completion(user, error)
            }
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                completion(result?.user, error)
            }
        }
    }

    func signOutFromGoogle() {
        GIDSignIn.sharedInstance.signOut()
    }
}

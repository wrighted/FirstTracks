//
// FirebaseStore.swift
// FirstTracks
//
// Created by Jared Webber on 2023-12-28
//

import Firebase
import FirebaseCore
import FirebaseFirestore
import Foundation

class FirebaseStore {
    static let shared = FirebaseStore()

    private init() {}

    func createUser(googleId: String) -> User {
        // TODO: implement
        return User()
    }

    func updateUser(user: User) {
        // TODO: implement
    }

    func fetchUser(googleId: String) -> User? {
        // TODO: test / revise
        let db = Firestore.firestore()
        let document = db.collection("users").document(googleId)

        do {
            var user = try Firestore.Decoder().decode(User.self, from: document)
            user.googleId = document.documentID

            return user

        } catch {
            print("Error decoding firebase document: \(error)")
            return nil
        }
    }
}

//
// FirebaseStore.swift
// bespoke
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

    func fetchNotes(completion: @escaping ([Note]) -> Void) {
        let db = Firestore.firestore()

        db.collection("notes").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting firebase documents: \(error)")
                completion([])

            } else {
                let notes: [Note] = querySnapshot?.documents.compactMap { document in
                    let data = document.data()

                    do {
                        var note = try Firestore.Decoder().decode(Note.self, from: data)
                        note.id = document.documentID

                        return note

                    } catch {
                        print("Error decoding firebase document: \(error)")
                        return nil
                    }
                } ?? []

                let sortedNotes = notes.sorted { $0.timestamp > $1.timestamp }
                completion(sortedNotes)
            }
        }
    }
}

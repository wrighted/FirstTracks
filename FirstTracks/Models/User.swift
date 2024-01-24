//
//  User.swift
//  FirstTracks
//
//  Created by Jared Webber on 2023-08-24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct User: Codable, Identifiable {
    // Seperate googleId and model id fields to avoid referencing google-specific info
    // outside of google interaction
    @DocumentID var id: String?
    var googleId: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var profileImage: URL?
    var username: String?
    var lastLogin: Double
    var accountCreated: Double
    var currentProvider: String?

    enum CodingKeys: String, CodingKey {
        case googleId
        case id
        case firstName
        case lastName
        case email
        case profileImage
        case username
        case lastLogin
        case accountCreated
        case currentProvider
    }

    init() {
        id = "0"
        firstName = ""
        lastName = ""
        email = "email@domain.com"
        profileImage = URL(string: "")
        username = ""
        lastLogin = Date().timeIntervalSince1970
        accountCreated = Date().timeIntervalSince1970
        currentProvider = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        email = try container.decode(String.self, forKey: .email)
        profileImage = try container.decode(URL.self, forKey: .profileImage)
        username = try container.decode(String.self, forKey: .username)
        lastLogin = try container.decode(TimeInterval.self, forKey: .lastLogin)
        accountCreated = try container.decode(TimeInterval.self, forKey: .accountCreated)
        currentProvider = try container.decode(String.self, forKey: .currentProvider)

        // Decode the DocumentID property using the Firestore decoder
        if let idContainer = try? decoder.container(keyedBy: CodingKeys.self),
           let googleId = try? idContainer.decode(String.self, forKey: .googleId)
        {
            self.googleId = googleId
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(profileImage, forKey: .profileImage)
        try container.encode(username, forKey: .username)
        try container.encode(lastLogin, forKey: .lastLogin)
        try container.encode(accountCreated, forKey: .accountCreated)
        try container.encode(currentProvider, forKey: .currentProvider)

        // Encode the DocumentID property using the Firestore encoder
        if id != nil {
            let firestoreEncoder = Firestore.Encoder()
            let encoded = try firestoreEncoder.encode(["googleId": googleId])

            if let encodedId = encoded["googleId"] as? String {
                try container.encode(encodedId, forKey: .googleId)
            }
        }
    }
}

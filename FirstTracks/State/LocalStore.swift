//
// LocalStore.swift
// FirstTracks
//
// Created by Jared Webber on 2023-09-25
//

import Foundation

let encoder = JSONEncoder()
let decoder = JSONDecoder()
let USER_KEY = "activeUser"

// Testing local storage

func updateUser(user: User) {
    if let encodedUser = try? encoder.encode(user) {
        UserDefaults.standard.set(encodedUser, forKey: USER_KEY)
    }
}

func getActiveUser() -> User {
    if let encodedUser = UserDefaults.standard.data(forKey: USER_KEY) {
        if let decodedUser = try? decoder.decode(User.self, from: encodedUser) {
            return decodedUser
        }
    }
    return .init()
}

//
// ProfileView.swift
// bespoke
//
// Created by Jared Webber on 2023-09-25
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var user: User
    @State private var firstName: String
    @State private var lastName: String
    @State private var username: String

    @EnvironmentObject var authManager: AuthManager

    init(user: Binding<User>) {
        _user = user
        _firstName = State(initialValue: user.wrappedValue.firstName ?? "")
        _lastName = State(initialValue: user.wrappedValue.lastName ?? "")
        _username = State(initialValue: user.wrappedValue.username ?? "")
    }

    var body: some View {
        Form {
            if authManager.authState == .signedIn {
                Section(header: Text("Profile Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    Text($user.wrappedValue.email ?? "") // Email can't be modified due to OAuth
                    TextField("Username", text: $username)
                }
            }
        }
        .navigationBarTitle("Profile")
        .navigationBarItems(
            trailing: Button(action: {
                $user.wrappedValue.firstName = firstName
                $user.wrappedValue.lastName = lastName
                $user.wrappedValue.username = username
                updateUser(user: $user.wrappedValue)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
        )
        .navigationBarItems(trailing:
            Button {
                signOut()

            } label: {
                Text("Sign Out")
            }
        )
    }

    func signOut() {
        Task {
            do {
                try await authManager.signOut()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

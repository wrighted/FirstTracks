//
//  AccountView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var activeUser: User = getActiveUser()
    
    var body: some View {
        if authManager.authState != .signedIn {
            LoginView()
        }
        else {
            ProfileView(user: $activeUser).environmentObject(authManager)
        }
    }
}

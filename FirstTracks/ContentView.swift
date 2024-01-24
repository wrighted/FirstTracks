//
//  ContentView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    DashboardView().tabItem
                }

            WorkoutsView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Ski Log")
                }
            
            SetTrackView()
                .tabItem {
                    Text("Set Tracks")
                    Image(systemName: "3.circle")
                }
            
            AccountView().environmentObject(authManager)
                .tabItem {
                    Text("Account")
                    Image(systemName: "4.circle")
                }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthManager())
}

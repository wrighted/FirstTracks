//
//  ContentView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dash", systemImage: "1.circle")
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
            
            AccountView()
                .tabItem {
                    Text("Account")
                    Image(systemName: "3.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}

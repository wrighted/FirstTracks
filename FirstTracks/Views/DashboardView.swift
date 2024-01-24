//
//  DashboardView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct DashboardView: View, TabItem {
    var body: some View {
        ScrollView {
            VStack {
                CardView(title: "Conditions", content: WeatherView(), height: 200)
            }
        }
        
    }
    
    var tabItem: some View {
        Label("Dash", systemImage: "1.circle")
    }
}

#Preview {
    DashboardView()
}

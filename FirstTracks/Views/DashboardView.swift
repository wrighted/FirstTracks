//
//  DashboardView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct DashboardView: View, TabItem {
    @State private var speed: Double = 30.0
    
    var body: some View {
        ScrollView {
            let maxSpeed: Double = 90.0
            
            VStack {
                ZStack {
                    Circle()
                        .rotation(.degrees(150))
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .opacity(0.2)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(speed / maxSpeed))
                        .stroke(Color.green.gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: true)
                    
                    Text("\(Int(speed)) km")
                        .font(.largeTitle)
                }
                .padding()
            }
            .padding()
            
            VStack {
                CardView(title: "Conditions", content: WeatherView(), height: 200, colour: .gray)
                    .padding()
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

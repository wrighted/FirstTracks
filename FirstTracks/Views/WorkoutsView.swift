//
//  WorkoutsView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-17.
//

import SwiftUI

struct WorkoutsView: View {
    var body: some View {
        NavigationView {
            CardStack(enableRotation: true, enableOffset: true)
        }
        .navigationTitle("Tracks Set")
    }
}

#Preview {
    WorkoutsView()
}

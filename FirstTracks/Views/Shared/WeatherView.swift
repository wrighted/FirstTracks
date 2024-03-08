//
//  WeatherView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-23.
//

import SwiftUI

struct BarChartView: View {
    var dataPoints: [Double]

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ForEach(dataPoints.indices, id: \.self) { index in
                BarView(value: dataPoints[index])
            }
        }
        .padding()
    }
}

struct BarView: View {
    var value: Double

    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: CGFloat(value * 10)) // Adjust height based on the data
            Text(String(format: "%.1f", value))
                .padding(.top, 5)
        }
    }
}


struct WeatherView: View, CardContentView {
    var body: some View {
        HStack {
            Image(systemName: "sun.min") // obvs too small
            BarChartView(dataPoints: [1, 2, 3, 4, 5])
        }
    }
}

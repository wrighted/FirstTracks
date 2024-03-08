//
//  SkiTrack.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-03-07.
//

import Foundation
import SwiftUI

struct SkiTrack: Identifiable {
    var id: UUID = .init()
    var color: Color
}

var tracks: [SkiTrack] = [
    .init(color: .red),
    .init(color: .blue),
    .init(color: .green),
    .init(color: .orange),
    .init(color: .pink),
    .init(color: .purple),
    .init(color: .yellow),
]

extension [SkiTrack] {
    func zIndex(_ track: SkiTrack) -> CGFloat {
        if let index = firstIndex(where: {$0.id == track.id}) {
            return CGFloat(count) - CGFloat(index)
        }
        
        return 0
    }
}

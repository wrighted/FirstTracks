//
//  CardStack.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-03-07.
//

import SwiftUI

struct CardStack: View {
    var enableRotation: Bool
    var enableOffset: Bool
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0){
                        ForEach(tracks) { track in
                            CardView(title: "Track", content: EmptyCardContentView(), height: 300, colour: track.color)
                                .padding(.horizontal, 65)
                                .frame(width: size.width)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                        .rotationEffect(rotation(geometryProxy, rotation: enableRotation ? 5 : 0))
                                        .offset(x: minX(geometryProxy))
                                        .offset(x: excessMinX(geometryProxy, offset: enableOffset ? 10 : 0))
                                }
                                .zIndex(tracks.zIndex(track))
                        }
                    }
                    .padding(.vertical, 15)
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
            }
            .frame(height: 380)
        }
    }
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 10) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        
        return progress * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 10) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }
}

#Preview {
    CardStack(enableRotation: true, enableOffset: true)
}

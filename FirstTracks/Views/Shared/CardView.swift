//
//  CardView.swift
//  FirstTracks
//
//  Created by Jared Webber on 2023-08-24.
//

import Foundation
import SwiftUI

protocol CardContentView {
    associatedtype ContentBody: View
    var body: ContentBody { get }
}

struct EmptyCardContentView: CardContentView {
    var body: some View {
        EmptyView()
    }
}

struct CardView<Content: CardContentView>: View {
    var title: String
    var content: Content
    var height: CGFloat
    var colour: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(colour.gradient)
            
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .padding()
                    Spacer()
                }
                .padding()
                content.body.padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: height)
            .cornerRadius(20)
            .padding()
        }
    }
}


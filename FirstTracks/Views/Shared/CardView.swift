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

struct CardView<Content: CardContentView>: View {
    var title: String
    var content: Content
    var height: CGFloat

    var body: some View {
        ZStack {
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
            .background(.gray.opacity(0.5))
            .cornerRadius(20)
            .padding()
        }
    }
}

//
//  CardView.swift
//  BeSpoke
//
//  Created by Jared Webber on 2023-08-24.
//

import Foundation
import SwiftUI

struct CardView: View {
    var title: String
    var content: AnyView

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .padding()
                    Spacer()
                }
                content.padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.5))
            .cornerRadius(20)
            .padding()
        }
    }
}

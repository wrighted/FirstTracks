//
//  TabView.swift
//  FirstTracks
//
//  Created by Ethan Wright on 2024-01-23.
//

import SwiftUI

protocol TabItem {
    associatedtype TabBody: View
    associatedtype Item: View
    var body: TabBody { get }
    var tabItem: Item { get }
}

//
//  ContentView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: Tabs = .topics
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Topics", systemImage: "menucard", value: .topics) {
                TopicsTab()
            }
            
            Tab("Stats", systemImage: "chart.line.uptrend.xyaxis", value: .stats) {
                StatsTab()
            }
        }
        .tabViewStyle(.tabBarOnly)
    }
    
}

#Preview {
    MainView()
        .modelContainer(for: Topic.self, inMemory: true)
}

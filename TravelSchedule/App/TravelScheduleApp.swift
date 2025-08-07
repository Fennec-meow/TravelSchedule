//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Kira on 01.07.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

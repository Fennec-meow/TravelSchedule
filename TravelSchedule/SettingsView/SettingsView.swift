//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Kira on 17.07.2025.
//

import SwiftUI

// MARK: - SettingsView

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        VStack {
            Toggle(isOn: $isDarkMode) {
                Text("Темная тема")
                    .font(.regular17)
                    .foregroundStyle(.blackForTheme)
            }
            .onAppear {
                isDarkMode = systemColorScheme == .dark
            }
            .tint(.blueUni)
            .padding(.vertical, 19)
            .padding(.horizontal, 16)
            
            HStack {
                NavigationLink(destination: UserAgreementView()) {
                    Text("Пользовательское соглашение")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    
                    Spacer()
                    
                    Image(.chevronRight)
                        .renderingMode(.template)
                        .foregroundStyle(.blackForTheme)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                Group {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    
                    Text("Версия 1.0 (beta)")
                }
                .multilineTextAlignment(.center)
                .lineSpacing(16)
                .tracking(0.4)
                .font(.regular12)
                .foregroundStyle(.blackForTheme)
            }
            .padding(.bottom, 24)
            Divider()
                .frame(height: 3)
        }
        .padding(.top, 24)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

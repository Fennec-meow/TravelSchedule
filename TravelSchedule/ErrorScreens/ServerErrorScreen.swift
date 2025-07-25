//
//  ServerErrorScreen.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import SwiftUI

// MARK: - ServerErrorScreen

struct ServerErrorScreen: View {
    
    // MARK: body

    var body: some View {
        VStack {
            Image("serverError")
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blackForTheme)
                
        }
    }
}

#Preview {
    ServerErrorScreen()
}

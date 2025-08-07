//
//  NoInternetScreen.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import SwiftUI

// MARK: - NoInternetScreen

struct NoInternetScreen: View {
    
    // MARK: body
    
    var body: some View {
        Image("noInternet")
            .frame(width: 223, height: 223)
            .clipShape(RoundedRectangle(cornerRadius: 70))
        Text("Нет интернета")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.blackForTheme)
    }
}

#Preview {
    NoInternetScreen()
}

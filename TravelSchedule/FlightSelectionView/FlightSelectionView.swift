//
//  FlightSelectionView.swift
//  TravelSchedule
//
//  Created by Kira on 16.07.2025.
//

import SwiftUI

// MARK: - FlightSelectionView

struct FlightSelectionView: View {
    
    // MARK: Public Property

    @Environment(\.dismiss) var dismiss
    var ticket: Ticket
    
    // MARK: body

    var body: some View {
        VStack {

        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("chevronLeft")
                        .renderingMode(.template)
                        .foregroundStyle(.blackForTheme)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.blackForTheme)
            }
        }
    }
}

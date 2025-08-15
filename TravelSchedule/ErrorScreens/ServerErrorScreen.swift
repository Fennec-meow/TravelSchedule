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
                .font(.bold24)
                .foregroundColor(.blackForTheme)
        }
    }
}

#Preview {
    ServerErrorScreen()
}

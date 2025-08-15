import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.whiteForTheme
                .ignoresSafeArea()
            
            if let url = URL(string: "https://yandex.ru/legal/practicum_offer") {
                WebView(url: url)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: { dismiss() }) {
                                Image(.chevronLeft)
                                    .renderingMode(.template)
                                    .foregroundColor(.blackForTheme)
                            }
                        }
                        
                        ToolbarItem(placement: .principal) {
                            Text("Пользовательское соглашение")
                                .font(.bold17)
                                .foregroundColor(.blackForTheme)
                        }
                    }
            } else {
                ServerErrorScreen()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserAgreementView()
}

import SwiftUI

// MARK: - SearchTextField

struct SearchTextField: View {
    
    // MARK: Public Property
    
    @Binding var text: String
    
    // MARK: body
    
    var body: some View {
        HStack {
            Image("magnifier")
                .foregroundStyle(.gray)
            
            TextField("Введите запрос", text: $text)
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(.chevronLeft)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.lightGray))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
    }
}

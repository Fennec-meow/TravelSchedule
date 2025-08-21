import SwiftUI

// MARK: - SearchTextField

struct SearchTextField: View {
    
    // MARK: Public Property
    
    @Binding var text: String
    
    // MARK: body
    
    var body: some View {
        HStack {
            Image("magnifier")
                .foregroundStyle(.grayUni)
            
            TextField("Введите запрос", text: $text)
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.grayUni)
                }
            }
        }
        .padding(10)
        .background(Color(.lightGray))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
    }
}

import SwiftUI

// MARK: - FlightSelectionView

struct FlightSelectionView: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FlightSelectionViewModel
    
    // MARK: body
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(viewModel.carrier?.logo ?? "FGC")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 343, maxHeight: 104)
            
            Text(viewModel.carrier?.title ?? "title")
                .font(.bold24)
                .padding(.vertical, 16)
                .foregroundColor(.blackForTheme)
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    
                    if let email = URL(string: viewModel.carrier?.email ?? "email") {
                        Link(destination: email) {
                            Text(viewModel.carrier?.email ?? "email")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Телефон")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    
                    if let phone = URL(string: viewModel.carrier?.phone ?? "phone") {
                        Link(destination: phone) {
                            Text(viewModel.carrier?.phone ?? "phone")
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.init(top: 0, leading: -16, bottom: 0, trailing: 16))
        .task {
            // TODO: убрать mock-данные
            await viewModel.fetchCarrier(code: "680")
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
                    .font(.bold17)
                    .foregroundStyle(.blackForTheme)
            }
        }
    }
}

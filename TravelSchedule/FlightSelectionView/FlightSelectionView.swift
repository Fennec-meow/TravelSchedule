import SwiftUI

// MARK: - FlightSelectionView

struct FlightSelectionView: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(ticket.operatorLogo)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 343, maxHeight: 104)
            
            Text(ticket.opf)
                .font(.bold24)
                .padding(.vertical, 16)
                .foregroundColor(.blackForTheme)
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    
                    if let email = URL(string: ticket.email) {
                        Link(destination: email) {
                            Text(ticket.email)
                        }
                    }
                }
                                
                VStack(alignment: .leading) {
                    Text("Телефон")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    
                    if let phone = URL(string: ticket.phone) {
                        Link(destination: phone) {
                            Text(ticket.phone)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.init(top: 0, leading: -16, bottom: 0, trailing: 16))
        
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

#Preview {
    FlightSelectionView(
        coordinator: NavCoordinator(),
        ticket: Ticket(
            operatorLogo: "RJD",
            carrierName: "РЖД",
            opf: "ООО «РЖД»",
            withTransfer: true,
            transfer: "С пересадкой в Костроме",
            date: "14 января",
            departure: "22:30",
            duration: "20 часов",
            arrival: "08:15",
            email: "ticket@rzd.ru",
            phone: "+7 (800) 201-43-56"
        ))
}

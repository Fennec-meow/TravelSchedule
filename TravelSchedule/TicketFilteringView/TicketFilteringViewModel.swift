import Foundation
import Combine

@MainActor
final class TicketFilteringViewModel: ObservableObject {
    
    // MARK: - Public state
    @Published var tickets: [Ticket] = []
    @Published var showTransfers: Bool?
    @Published var coordinator = NavCoordinator()
    @Published var departureTime: Set<DepartureTime> = []
    
    // Станции (коды Яндекс.Расписаний)
    @Published var fromStation: String = ""
    @Published var toStation: String = ""
    
    // MARK: - Deps
    private let schedualBetweenStationsService: SchedualBetweenStationsServiceProtocol
    
    private var todayStr: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.timeZone = .current
        return df.string(from: Date())
    }
    
    // MARK: - Init
    init(schedualBetweenStationsService: SchedualBetweenStationsServiceProtocol) {
        self.schedualBetweenStationsService = schedualBetweenStationsService
    }
    
    // MARK: - Filtering (как и раньше)
    var filteredTickets: [Ticket] {
        tickets.filter { ticket in
            if let show = coordinator.showTransfers, show != ticket.withTransfer { return false }
            if !coordinator.timeFilters.isEmpty {
                return coordinator.timeFilters.contains(ticket.departurePeriod)
            }
            return true
        }
    }
    
    // MARK: - Load
    func fetchTickets() async {
        do {
            let resp = try await schedualBetweenStationsService.getSchedualBetweenStations(
                from: fromStation,
                to: toStation,
                date: todayStr
            )
            self.tickets = Self.mapTickets(from: resp)
        } catch {
            // здесь можно повесить ErrorHandleable и показывать экран ошибки
            print("Tickets load error:", error.localizedDescription)
            self.tickets = []
        }
    }
}

// MARK: - Mapping
extension TicketFilteringViewModel {
    
    /// Маппинг API-модели Segments в массив Ticket
    static func mapTickets(from resp: Components.Schemas.Segments) -> [Ticket] {
        let segments = resp.segments ?? []
        return segments.compactMap { seg in
            // Время отправления/прибытия
            let dep = parseDateOrTime(seg.departure, asTime: true)
            let arr = parseDateOrTime(seg.arrival, asTime: true)
            
            // Длительность
            let seconds = Int(seg.duration ?? 0)
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let duration =
            hours > 0 ? "\(hours) ч \(minutes) мин" :
            (minutes > 0 ? "\(minutes) мин" : "—")
            
            // Перевозчик
            let carrier = seg.thread?.carrier
            let name = carrier?.title ?? "—"
            let logo = carrier?.logo ?? ""
            let code = carrier?.code
            
            // Дата (из departure)
            let date = parseDateOrTime(seg.departure, asTime: false)
            
            return Ticket(
                code: code,
                operatorLogo: logo,
                carrierName: name,
                withTransfer: false,
                transfer: nil,
                date: date,
                departure: dep,
                duration: duration,
                arrival: arr
            )
        }
    }
    
    /// Форматирование `Date?` в строку:
    /// - `asTime = true` → "HH:mm"
    /// - `asTime = false` → "d MMMM"
    private static func parseDateOrTime(_ date: Date?, asTime: Bool) -> String {
        guard let date else { return "—" }
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.timeZone = .current
        df.dateFormat = asTime ? "HH:mm" : "d MMMM"
        return df.string(from: date)
    }
}

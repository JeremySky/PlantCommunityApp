import Foundation

extension Date {
    func timeAgo() -> String {
        let now = Date()
        let secondsAgo = now.timeIntervalSince(self)
        let oneHour: TimeInterval = 3600
        let oneDay: TimeInterval = 86400
        let oneWeek: TimeInterval = oneDay * 7
        
        if secondsAgo < oneHour {
            return "Just now"
        } else if secondsAgo < oneWeek {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: now)
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: self)
        }
    }
}

import Foundation

enum LogLevel: String {
    case info = "💡"
    case debug = "🐛"
    case warning = "⚠️"
    case error = "❌"
}

func log(_ message: String,
         level: LogLevel = .debug,
         function: String = #function,
         file: String = #file,
         line: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(level.rawValue) [\(fileName):\(line)] \(function): \(message)")
    #endif
}

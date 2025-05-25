import SwiftUI

enum CustomAlert: Error, LocalizedError {
    case unknownError(onOKPressed: () -> Void)
    
    var title: String {
        switch self {
        case .unknownError:
            return "Unknown Error"
        }
    }
    var subtitle: String? {
        switch self {
        case .unknownError:
            return nil
        }
    }
    
    var getButtons: some View {
        switch self {
        case .unknownError(let onOKPressed):
            return Button("OK") { onOKPressed() }
        }
    }
}

extension View {
    func showCustomAlert(alert: Binding<CustomAlert?>) -> some View {
        self
            .alert(
                alert.wrappedValue?.title ?? "Error",
                isPresented: Binding(value: alert),
                actions: { alert.wrappedValue?.getButtons },
                message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
            )
    }
}

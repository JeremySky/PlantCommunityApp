import Foundation

enum Loadable<T> {
    case loading
    case loaded(T)
    case failed(Error)
}

import Foundation


struct Todo: Codable {
    let id: UUID
    let title: String
    var isCompleted: Bool
}

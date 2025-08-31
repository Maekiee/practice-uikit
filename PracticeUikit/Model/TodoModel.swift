import Foundation


struct Todo: Codable {
    let id: UUID
    let title: String
    let isCompleted: Bool
}

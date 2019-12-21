import Foundation
import Vapor
import FluentPostgreSQL

final class Participant: Content {
    static let entity = "participants"
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var createdAt: Date?
    var updatedAt: Date?

    var id: UUID?
    var userID: UUID
    var conversationID: UUID

    public init(userID: UUID, conversationID: UUID) {
        self.userID = userID
        self.conversationID = conversationID
    }
}



extension Participant: Migration {}
extension Participant: Parameter {}
extension Participant: PostgreSQLUUIDModel {}
import Foundation
import Vapor
import FluentPostgreSQL

final class Conversation: Content {
    static let entity = "conversations"
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var createdAt: Date?
    var updatedAt: Date?

    var id: UUID?
}

extension Conversation {
    var participants: Children<Conversation, Participant> {
        return children(\.conversationID)
    }
    var messages: Children<Conversation, Message> {
        return children(\.conversationID)
    }
}

extension Conversation: Migration {}
extension Conversation: PostgreSQLUUIDModel {}
extension Conversation: Parameter {}
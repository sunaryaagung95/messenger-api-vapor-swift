import Vapor
import FluentPostgreSQL
import Foundation

final class Message {
    static let entity = "messages"     //table name
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var id: UUID?
    var receiverID: UUID?
    let senderID: UUID
    let conversationID: UUID
    var content: String?
    var createdAt: Date?
    var updatedAt: Date?

    public init(content: String, userID: UUID, conversationID: UUID) {
        self.content = content
        self.senderID = userID
        self.conversationID = conversationID
    }
}

extension Message {
    var sender: Parent<Message, User> {
        return parent(\.senderID)
    }
    var receiver: Parent<Message, User>? {
        return parent(\.receiverID)
    }
    var conversation: Parent<Message, Conversation> {
        return parent(\.conversationID)
    }
}


extension Message: Content {}
extension Message: Parameter {}
extension Message: PostgreSQLUUIDModel {}
extension Message: Migration { }
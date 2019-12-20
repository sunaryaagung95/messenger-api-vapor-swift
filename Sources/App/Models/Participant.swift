import Foundation
import Vapor
import FluentPostgreSQL

final class Participant: Content {
    static let entity = "participants"

    var id: UUID?
    var userID: User.ID
    var conversationID: Conversation.ID

    public init(userID: User.ID, conversationID: Conversation.ID) {
        self.userID = userID
        self.conversationID = conversationID
    }
}

extension Participant: Migration {}
extension Participant: Parameter {}
extension Participant: PostgreSQLUUIDModel {}
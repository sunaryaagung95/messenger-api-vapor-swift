import Foundation
import Vapor
import FluentPostgreSQL

final class Conversation: Content {
    static let entity = "conversations"
    var id: UUID?
}

extension Conversation: Migration {}
extension Conversation: PostgreSQLUUIDModel {}
extension Conversation: Parameter {}
import Vapor
import FluentPostgreSQL
import Foundation

final class Message {
    static let entity = "messages"     //table name


    var id: UUID?
    let userID: User.ID
    var content: String?

    public init(content: String, userID: User.ID) {
        self.content = content
        self.userID = userID
    }
}

extension Message: Migration {
    public static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in 
            try addProperties(to: builder)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

extension Message: Content {}
extension Message: Parameter {}
extension Message: PostgreSQLUUIDModel {}
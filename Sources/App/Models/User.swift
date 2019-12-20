import Vapor
import FluentPostgreSQL
import Foundation

final class User: Content, Parameter {
    static let entity = "users"     //table name

    var id: UUID?
    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

extension User {
    var messages: Children<User, Message> {
        return self.children(\.userID)
    }
    var participants: Children<User, Participant> {
        return self.children(\.userID)
    }
}

extension User: Migration {
    public static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.unique(on: \.email)
        }
    }
}

extension User: PostgreSQLUUIDModel {}
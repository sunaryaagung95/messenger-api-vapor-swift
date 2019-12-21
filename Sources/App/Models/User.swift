import Vapor
import FluentPostgreSQL
import Foundation

final class User: Content, Parameter {
    static let entity = "users"     //table name
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var createdAt: Date?
    var updatedAt: Date?

    var id: UUID?
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
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
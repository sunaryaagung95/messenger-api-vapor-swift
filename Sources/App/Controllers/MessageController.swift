import Foundation
import Vapor
import Fluent

final class MessageController: RouteCollection {
    func boot(router: Router) throws {
        let messages = router.grouped("api", "messages")

        messages.post(Message.self, use: create)
        
        messages.get(Conversation.parameter, use: getAll)

        messages.delete(Message.parameter, use: delete)
    }

    func create(_ req: Request, _ message: Message) throws -> Future<Message> {
        return message.save(on: req)
    }

    func getAll(_ req: Request) throws -> Future<[Message]> {
        return try req.parameters.next(Conversation.self).flatMap { conversation in
            return try conversation.messages.query(on: req).all()
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Message.self).delete(on: req).transform(to: .noContent)
    }
}